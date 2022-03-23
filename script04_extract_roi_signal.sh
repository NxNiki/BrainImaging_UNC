#!bin/bash
set -e
# extract ROI signals based on specific atlas for each subject.

##### Step01: compute mean for each atlase ##########

img_dir="out03_adni_fmri_t1_dpsfa1/FunImgAR"
out_dir="out04_adni_roi_signals/"
atlas="/home/xin/Downloads/DPABI_V6.1_220101/Templates/Power_Neuron_264ROIs_Radius5_Mask.nii"

# ---------------------------------------------------

mkdir -p $out_dir
rm -f tmp_roi_*.txt

for img in $(find $img_dir/ -name 'rarest_bold.nii');
do
    sub_dir=${img%%/rarest_bold.nii}
    sub_id=${sub_dir##*/}
    echo $sub_id
    echo $img
    flirt -in $atlas -ref $img -nosearch -out tmp_atlas.nii
    # compute mean for each region in the atlas:
    index=1
    while [ $index -ne 265 ]
    do
        echo $index
        # create temp_mask for roi:
    	fslmaths tmp_atlas -uthr $index -thr $index tmp_mask
        fslmeants -i $img -o tmp_roi_${index}.txt -m tmp_mask
    	#fslmaths $img -mul tmp_mask tmp_roi.nii.gz
    	#fslstats -t tmp_roi.nii.gz -M > tmp_roi_${index}.txt
        index=$(($index+1))
    done

    ########## Step02: combine data for all atlases ##########

    ls tmp_roi_*.txt | tr "\n" "\t"| sed 's/tmp_roi_//g'| sed 's/.txt//g' > $out_dir/roi_signals_power264_${sub_id}.txt
    
    # add Feed Line, echo automaticlly add \n at the end of line, so we just add an empty charactor:
    echo "" >> $out_dir/roi_signals_power264_${sub_id}.txt
    
    paste -d "\t" tmp_roi_*.txt >> $out_dir/roi_signals_power264_${sub_id}.txt
    rm tmp_roi_*.txt

done
