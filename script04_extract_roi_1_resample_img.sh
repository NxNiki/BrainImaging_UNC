#!bin/sh
set -e
# resample bold images to match template before we can
# extract ROI signals based on specific atlas for each subject.

img_dir="out03_adni_fmri_t1_dpsfa4/FunImgAR"
atlas="/home/xin/Downloads/DPABI_V6.1_220101/Templates/Power_Neuron_264ROIs_Radius5_Mask.nii"

img=$(find $img_dir -name 'rarest_bold.nii' | head -n 1)
for sub_dir in $img_dir/sub*;
do
echo $sub_dir
# split 4-D images to separate 3-D images:
fslsplit $sub_dir/rarest_bold.nii
# down sampling 3-D images to same resolution as template:

for img in vol*.nii.gz;
do
    img_name=${img%%.nii.gz}
    echo $img_name
    flirt -in $img -ref $template -out tmp_flirt_${img_name}
done
done

fslmerge -t $sub_dir/rarest_bold_downsample `imglob tmp_flirt_*.nii.gz`
rm tmp_flirt_*.nii.gz
rm vol*.nii.gz

