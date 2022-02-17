#!/bin/sh

## convert dcm files to nii for rsfMRI data:

data_dir='/home/xin/Downloads/ADNIDOD_backup'
## create a list of directories of rsfMRI dcm files.

#ls -d $data_dir/0*/Axial_rsfMRI*/*/I*>out01_rsfmri_dir1.txt
ls -d $data_dir/0*/*rsFMRI*/*/I*>out01_rsfmri_dir2.txt

echo number of files:
echo $(wc -l out01_rsfmri_dir1.txt)

while read sub_dir;
do
	echo $sub_dir
	dcm2niix $sub_dir/
done <out01_rsfmri_dir2.txt

