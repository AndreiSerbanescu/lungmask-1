#!/usr/bin/python3

# run with eg.:
#   ./convert.py Case_0*

import sys
import glob
import SimpleITK as sitk

# code snippet from Amir
def read_dicom(files):
    """
    read dicom images from directory

    :param files: dir path that contain the dicom files
    :return: simpleitk image
    """
    reader = sitk.ImageSeriesReader()
    dicom_names = reader.GetGDCMSeriesFileNames(files)
    reader.SetFileNames(dicom_names)
    return reader.Execute()

for dirname in sys.argv[1:]:
    print(f"processing {dirname} ...")
    image = read_dicom(dirname)
    sitk.WriteImage(image, f"{dirname}.nii.gz")
