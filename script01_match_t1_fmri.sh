#!/bin/sh

## list fmri and mri files and find ones with common subjects and put them into a single directory for each subject

## fmri files:

data_dir_fmri='/home/xin/Downloads/ADNI_FMRI'
data_dir_t1='/home/xin/Downloads/ADNI_T1'

out_dir="out02_adni_fmri_t1"

if [ ! -d $out_dir ]
then
	mkdir $out_dir 
fi

# for T1 images:
ls -d $data_dir_t1/*_S_*/MPRAGE/*/S*/*.nii>temp_t1.txt

# rsfMRI images
ls -d $data_dir/*_S_*/*rs[f,F]MRI*/*/I*/*.nii>temp_fun.txt
ls -d $data_dir/*_S_*/*fcMRI*/*/I*/*.nii>>temp_fun.txt
ls -d $data_dir/*_S_*/*Resting_State_fMRI/*/I/*.nii>>temp_fun.txt
ls -d $data_dir/*_S_*/AXIAL_RS_fMRI*/*/I*/*.nii>>temp_fun.txt

ls -d $data_dir/*_S_*/*rs[f,F]MRI*/*/I*/*.json>temp_json.txt
ls -d $data_dir/*_S_*/*fcMRI*/*/I*/*.json>>temp_json.txt
ls -d $data_dir/*_S_*/*Resting_State_fMRI/*/I/*.json>>temp_json.txt
ls -d $data_dir/*_S_*/Axial_fcMRI*/*/I*/*.json>>temp_json.txt

cat temp_t1.txt | awk -F '/' '{print $5 $7}' > sub_session_t1.txt
cat temp_fun.txt | awk -F '/' '{print $5 $7}' > sub_session_fun.txt
