#!bin/bash
set -e
# extract ROI signals based on specific atlas for each subject.

##### Step01: compute mean for each atlase ##########

#img_dir="out03_adni_fmri_t1_dpsfa1/FunImgAR"
#out_dir="out04_adni_roi_signals1"

#img_dir="out03_adni_fmri_t1_dpsfa2/FunImgAR"
#out_dir="out04_adni_roi_signals2"

#img_dir="out03_adni_fmri_t1_dpsfa3/FunImgAR"
#out_dir="out04_adni_roi_signals3"

#img_dir="out03_adni_fmri_t1_dpsfa4/FunImgAR"
#out_dir="out04_adni_roi_signals4"

#img_dir="out03_adni_fmri_t1_dpsfa5/FunImgAR"
#out_dir="out04_adni_roi_signals5"

img_dir="out03_adni_fmri_t1_dpsfa6/FunImgAR"
out_dir="out04_adni_roi_signals6"


atlas="/home/xin/Downloads/DPABI_V6.1_220101/Templates/Power_Neuron_264ROIs_Radius5_Mask.nii"

# ---------------------------------------------------

mkdir -p $out_dir
rm -f $out_dir/tmp_roi_*.txt

for img in $(find $img_dir/ -name 'rarest_bold.nii');
do
    sub_dir=${img%%/rarest_bold.nii}
    sub_id=${sub_dir##*/}
    echo $sub_id
    echo $img
    flirt -in $atlas -ref $img -nosearch -out $out_dir/tmp_atlas.nii
    # compute mean for each region in the atlas:
    index=1
    while [ $index -ne 265 ]
    do
        #echo $index
        # create temp_mask for roi:
    	fslmaths $out_dir/tmp_atlas -uthr $index -thr $index $out_dir/tmp_mask
        fslmeants -i $img -o $out_dir/tmp_roi_${index}.txt -m $out_dir/tmp_mask
    	#fslmaths $img -mul tmp_mask tmp_roi.nii.gz
    	#fslstats -t tmp_roi.nii.gz -M > tmp_roi_${index}.txt
        index=$(($index+1))
    done
    

    ########## Step02: combine data for all atlases ##########

    # fill roi index as file header:
    ls $out_dir/tmp_roi_*.txt | sed 's/^.*\(tmp_roi_\)//'| sed 's/.txt//g' | tr "\n" "\t"> $out_dir/roi_signals_power264_${sub_id}.txt
    
    # add Feed Line, echo automaticlly add \n at the end of line, so we just add an empty charactor:
    echo "" >> $out_dir/roi_signals_power264_${sub_id}.txt
    
    # fill roi signals:
    paste -d "\t" $out_dir/tmp_roi_*.txt >> $out_dir/roi_signals_power264_${sub_id}.txt
    echo $(cat $out_dir/roi_signals_power264_${sub_id}.txt | wc -l)
    rm $out_dir/tmp_roi_*.txt
    rm $out_dir/tmp_*.nii.gz

done
