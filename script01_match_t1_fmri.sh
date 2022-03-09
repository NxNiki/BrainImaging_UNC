#!/bin/sh

## list fmri and mri files and find ones with common subjects 

## fmri and t1 directory:

data_dir_fmri='/home/xin/Downloads/ADNI_FMRI'
data_dir_t1='/home/xin/Downloads/ADNI_T1'

# for T1 images:
ls -d $data_dir_t1/*_S_*/MPRAGE/*/S*/*.nii>temp_t1.txt

# rsfMRI images
ls -d $data_dir_fmri/*_S_*/*rs[f,F]MRI*/*/I*>temp_fun.txt
ls -d $data_dir_fmri/*_S_*/*fcMRI*/*/I*>>temp_fun.txt
ls -d $data_dir_fmri/*_S_*/*Resting_State_fMRI/*/I*>>temp_fun.txt
ls -d $data_dir_fmri/*_S_*/AXIAL_RS_fMRI*/*/I*>>temp_fun.txt

#ls -d $data_dir_fmri/*_S_*/*rs[f,F]MRI*/*/I*/*.nii>temp_fun.txt
#ls -d $data_dir_fmri/*_S_*/*fcMRI*/*/I*/*.nii>>temp_fun.txt
#ls -d $data_dir_fmri/*_S_*/*Resting_State_fMRI/*/I*/*.nii>>temp_fun.txt
#ls -d $data_dir_fmri/*_S_*/AXIAL_RS_fMRI*/*/I*/*.nii>>temp_fun.txt

#ls -d $data_dir_fmri/*_S_*/*rs[f,F]MRI*/*/I*/*.json>temp_json.txt
#ls -d $data_dir_fmri/*_S_*/*fcMRI*/*/I*/*.json>>temp_json.txt
#ls -d $data_dir_fmri/*_S_*/*Resting_State_fMRI/*/I/*.json>>temp_json.txt
#ls -d $data_dir_fmri/*_S_*/Axial_fcMRI*/*/I*/*.json>>temp_json.txt

cat temp_t1.txt | awk -F '/' '{print $6}' | sort | uniq > temp_sub_t1.txt
cat temp_fun.txt | awk -F '/' '{print $6}' | sort | uniq > temp_sub_fun.txt
comm -12 temp_sub_t1.txt temp_sub_fun.txt > out01_sub_comm.txt

rm temp*.txt
