import subprocess as sb
import argparse
import yaml
import os

def validate_output(output):

    split = os.path.split(output)

    if '.' not in split[1]:
        return output, "output.nii.gz"

    return split

# if source is of form ./source_path           returns ./source_path
# if soruce is of form ./source_path/dicom.dcm returns ./source_path
def validate_source(source):

    split = os.path.split(source)
    if '.' not in split[1]:
        return source

    return split[0]

if __name__ == "__main__":

    parser = argparse.ArgumentParser(description="lungmask_converter")

    parser.add_argument('-o', '--output', required=True, type=str, help="Host path to output directory or filename")
    parser.add_argument('-s', '--source', default="", type=str,
                        help="Host path to dcm source volume directory or filename")
    parser.add_argument('--debug', action='store_true',
                        help="Select this for container to not perform any computation")

    args = parser.parse_args()

    with open('docker-compose.yml') as docker_compose_file:

        dc = yaml.load(docker_compose_file)

        source_dir = validate_source(args.source)
        output_dir, output_filename = validate_output(args.output)

        source = '{}:/home/source'.format(source_dir)
        output = '{}:/home/output'.format(output_dir)

        volumes = [source, output]

        dc['services']['lungmask_converter']['volumes'] = volumes

        if args.debug:
            dc['services']['lungmask_converter']['command'] = 'tail -F anything'

        environment = ["DEBUG={}".format(args.debug), "OUTPUT_NAME={}".format(output_filename)]

        old_env = dc['services']['lungmask_converter'].get('environment', [])
        dc['services']['lungmask_converter']['environment'] = environment + old_env


    new_dc_file = 'docker-compose-tmp.yml'

    if os.path.exists(new_dc_file):
        os.remove(new_dc_file)

    with open(new_dc_file, 'w') as docker_compose_tmp_file:
        yaml.dump(dc, docker_compose_tmp_file)

    docker_compose_up_cmd = "docker-compose down --volumes " \
                            "&& docker-compose -f {} up --build".format(new_dc_file)
    sb.call([docker_compose_up_cmd], shell=True)

