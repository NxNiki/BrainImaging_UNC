#!/bin/sh




## convert dcm files to nii for rsfMRI data:

#data_dir='/home/xin/Downloads/ADNIDOD_backup'
data_dir='/ram/USERS/xin/ADNI'
## list all the subdirectories to identifiy folders for rsfMRI data:
ls -d $data_dir/*_S_*/*/ | awk -F '/' '{print $6}' | sort | uniq > out01_uniq_dir.txt
ls -d $data_dir/*_S_*/*/*/*/ | sort > out01_all_dir.txt

## create a list of directories of rsfMRI dcm files.

#ls -d $data_dir/0*/Axial_rsfMRI*/*/I*>out01_rsfmri_dir1.txt
#ls -d $data_dir/0*/*rsFMRI*/*/I*>out01_rsfmri_dir2.txt
ls -d $data_dir/*_S_*/*Resting_State_fMRI/*/I*>out01_rsfmri_dir3.txt
#ls -d $data_dir/*_S_*/*fcMRI*/*/I*>out01_rsfmri_dir4.txt

echo number of files:
echo $(wc -l out01_rsfmri_dir3.txt)

while read sub_dir;
do
	echo $sub_dir
	dcm2niix $sub_dir/
done <out01_rsfmri_dir3.txt

