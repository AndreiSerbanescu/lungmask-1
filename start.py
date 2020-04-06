import subprocess as sb
import os


# '&& find / -type f -iname "*.nii.gz" '
def run_lungmask():
    cmd = 'python3 /app/convert.py /home/source ' \
          "&& mv /home/source.nii.gz /home/output/{}".format(os.environ["OUTPUT_NAME"])

    sb.call([cmd], shell=True)


if __name__ == "__main__":
    run_lungmask()