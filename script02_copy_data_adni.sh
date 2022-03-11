#!/bin/sh

# copy t1 and fmri images into a single directory for each subject

## fmri files:

data_dir_fmri='/home/xin/Downloads/ADNI_FMRI'
data_dir_t1='/home/xin/Downloads/ADNI_T1'

out_dir="out02_adni_fmri_t1"

if [ ! -d $out_dir ]
then
	mkdir $out_dir 
fi

while read sub
do
    subid='sub-'$(echo $sub) 
    # list all sessions of fmri data for current subject:

    ls -d $data_dir_fmri/$sub/*rs[f,F]MRI*/*/I*>temp_fun_sub.txt
    ls -d $data_dir_fmri/$sub/*fcMRI*/*/I*>>temp_fun_sub.txt
    ls -d $data_dir_fmri/$sub/*Resting_State_fMRI/*/I*>>temp_fun_sub.txt
    ls -d $data_dir_fmri/$sub/AXIAL_RS_fMRI*/*/I*>>temp_fun_sub.txt
    echo 'temp_fun_sub.txt:'
    cat temp_fun_sub.txt

    t1_file=$(ls -d $data_dir_t1/$sub/MPRAGE/*/S*/*.nii | tail -1)
    echo $t1_file

    while read line2
    do
        sesid='ses-'$(echo $line2 | awk -F '/' '{print $8}') 

        mkdir -p $out_dir/$subid/$sesid/anat
        mkdir -p $out_dir/$subid/$sesid/func

        cp $line2/*.nii $out_dir/$subid/$sesid/func/${subid}-${sesid}_task-rest_bold.nii
        cp $line2/*.json $out_dir/$subid/$sesid/func/${subid}-${sesid}_task-rest_bold.json
        gzip $out_dir/$subid/$sesid/func/${subid}-${sesid}_task-rest_bold.nii

        #cp $t1_file $out_dir/$subid/$sesid/anat/${subid}-${sesid}_T1w.nii
        #gzip $out_dir/$subid/$sesid/anat/${subid}-${sesid}_T1w.nii

    done < temp_fun_sub.txt
done < out01_sub_comm.txt
