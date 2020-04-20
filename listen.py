import subprocess as sb
import os
import time
from common.utils import *
from common import listener_server

def convert(param_dict):
    print("### converter got parameters {}".format(param_dict))

    rel_source_dir = param_dict["source_dir"][0]
    # remove trailing / at the beggining of name
    # otherwise os.path.join has unwanted behaviour for base dirs
    # i.e. join(/app/data_share, /app/wrongpath) = /app/wrongpath
    rel_source_dir = rel_source_dir.lstrip('/')

    data_share     = os.environ["DATA_SHARE_PATH"]
    source_dir     = os.path.join(data_share, rel_source_dir)

    rel_output_dir = "converter-output-" + str(time.time()) + ".nii.gz"
    output_dir     = os.path.join(data_share, rel_output_dir)

    conversion_command = "python3 /app/convert.py {} && mv {}.nii.gz {}".format(source_dir, source_dir, output_dir)
    exit_code = sb.call([conversion_command], shell=True)

    # if conversion_command wasn't successful
    if exit_code == 1:
        return {}, False

    result_dict = { "filename":  rel_output_dir}
    return result_dict, True


if __name__ == "__main__":

    setup_logging()
    log_info("Started listening")

    served_requests = {
        "/lungmask_convert_dcm_to_nifti": convert
    }

    listener_server.start_listening(served_requests, multithreaded=True, mark_as_ready_callback=mark_yourself_ready)