#!/bin/sh

## split fmri and t1 images into groups with same scanning settings
## based on TRinfo.tsv created by dparsfa.

## select all images with slice number:48 and time points 140

awk -F '\t' '$3=="48" && $4=="140"' out02_adni_fmri_t1_dpsfa/TRInfo.tsv > out03_subject_group1.txt
#
#awk -F '\t' '$3=="48" && $4=="197"' out02_adni_fmri_t1_dpsfa/TRInfo.tsv > out03_subject_group2.txt
#
#awk -F '\t' '$3=="64" && $4=="976"' out02_adni_fmri_t1_dpsfa/TRInfo.tsv > out03_subject_group3.txt
#
#awk -F '\t' '$3=="48" && $4=="200"' out02_adni_fmri_t1_dpsfa/TRInfo.tsv > out03_subject_group4.txt
#
#awk -F '\t' '$3=="36" && $4=="140"' out02_adni_fmri_t1_dpsfa/TRInfo.tsv > out03_subject_group5.txt
#
#awk -F '\t' '$3=="64" && $4=="750"' out02_adni_fmri_t1_dpsfa/TRInfo.tsv > out03_subject_group6.txt

out_dir=out03_adni_fmri_t1_dpsfa1
mkdir -p $out_dir/FunImg
mkdir -p $out_dir/T1Img

while read line;
do

    subid=$(echo $line | awk -F ' ' '{print $1}')
    echo $subid
    mkdir -p $out_dir/FunImg/$subid/
    mkdir -p $out_dir/T1Img/$subid/
    cp out02_adni_fmri_t1_dpsfa/FunImg/$subid/rest_bold.nii $out_dir/FunImg/$subid/rest_bold.nii
    cp -l out02_adni_fmri_t1_dpsfa/T1Img/$subid/T1w.nii $out_dir/T1Img/$subid/T1w.nii

done<out03_subject_group1.txt
    

