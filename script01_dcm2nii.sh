#!/bin/sh

## convert dcm files to nii for rsfMRI data:

#data_dir='/ram/USERS/xin/ADNI_FMRI'
data_dir='/home/xin/Downloads/ADNI_FMRI'
#data_dir='/ram/USERS/xin/ADNI_DOD_MRI'

out_file='out01_adni_fmri.txt'

## list all the subdirectories to identifiy folders for rsfMRI data:
ls -d $data_dir/*_S_*/*/ | awk -F '/' '{print $7}' | sort | uniq > temp_unqiue_dir.txt
ls -d $data_dir/*_S_*/*/*/*/ | sort > temp_all_dir.txt

## create a list of directories of rsfMRI dcm files.

#ls -d $data_dir/0*/Axial_fcMRI*/*/I*>$out_file
#ls -d $data_dir/0*/*rsFMRI*/*/I*>>$out_file
#ls -d $data_dir/0*/*rsfMRI*/*/I*>>$out_file
#ls -d $data_dir/0*/AXIAL_RS_fMRI*/*/I*>>$out_file

#ls -d $data_dir/0*/*rs[f,F]MRI*/*/I*>$out_file
#ls -d $data_dir/0*/*Resting_State_fMRI*/*/I*>$out_file
#ls -d $data_dir/0*/*resting_state/*/I*>>$out_file

ls -d $data_dir/*_S_*/*Resting_State_fMRI/*/I*>$out_file
ls -d $data_dir/*_S_*/*fcMRI*/*/I*>>$out_file
ls -d $data_dir/*_S_*/*rsFMRI*/*/I*>>$out_file
ls -d $data_dir/*_S_*/*rsfMRI*/*/I*>>$out_file
ls -d $data_dir/*_S_*/AXIAL_RS_fMRI*/*/I*>>$out_file


echo number of files:
echo $(wc -l $out_file)

while read sub_dir;
do
	echo $sub_dir
	dcm2niix $sub_dir/
done < $out_file

