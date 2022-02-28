#! bin/sh

## create bids file structure for rsfMRI data:

#data_dir='/ram/USERS/xin/ADNIDOD_fMRI'
data_dir='/ram/USERS/xin/ADNI_DOD_MRI'

out_dir="out02_adni_dod_mri"

if [ ! -d $out_dir ]
then
	mkdir $out_dir 
fi

# for T1 images:
ls -d $data_dir/0*/*T1_image/*/I*/*.nii>temp_t1.txt
#ls -d $data_dir/0*/*T1_image/*/I*/*.json>>temp.txt

# rsfMRI images
ls -d $data_dir/0*/*rs[f,F]MRI*/*/I*/*.nii>temp_fun.txt
ls -d $data_dir/0*/Axial_fcMRI*/*/I*/*.nii>>temp_fun.txt
ls -d $data_dir/0*/AXIAL_RS_fMRI*/*/I*/*.nii>>temp_fun.txt

ls -d $data_dir/0*/*rs[f,F]MRI*/*/I*/*.json>temp_json.txt
ls -d $data_dir/0*/Axial_fcMRI*/*/I*/*.json>>temp_json.txt
ls -d $data_dir/0*/AXIAL_RS_fMRI*/*/I*/*.json>>temp_json.txt

while read line;
do
	subid=sub-$(echo $line| awk -F '/' '{print $6}')
	session=ses-$(echo $line| awk -F '/' '{print $8}')
#	session=${session//-/.}	
	new_dir=$out_dir/${subid}_$session/anat
	
	echo $new_dir

	if [ ! -d $new_dir ]
	then
		mkdir -p ${new_dir}
	fi

	cp -l $line $new_dir/${subid}_${session}_T1w.nii

	fslinfo $line

done < temp_t1.txt 

while read line;
do
	subid=sub-$(echo $line| awk -F '/' '{print $6}')
	session=ses-$(echo $line| awk -F '/' '{print $8}')
#	session=${session//-/.}	
	
	new_dir=$out_dir/${subid}_$session/func
	
	echo $new_dir

	if [ ! -d $new_dir ]
	then
		mkdir -p $new_dir
	fi

	cp -l $line $new_dir/${subid}_${session}_rest_bold.nii

	fslinfo $line

done < temp.txt 


while read line;
do
	subid=sub-$(echo $line| awk -F '/' '{print $6}')
	session=ses-$(echo $line| awk -F '/' '{print $8}')
#	session=${session//-/.}	
	
	new_dir=$out_dir/${subid}_$session/func
	
	echo $new_dir

	if [ ! -d $new_dir ]
	then
		mkdir -p $new_dir
	fi

	cp -l $line $new_dir/${subid}_${session}_rest_bold.json

done < temp_json.txt 

#rm temp.txt
