#! bin/sh

## create bids file structure for rsfMRI data:

data_dir='/ram/USERS/xin/ADNIDOD_fMRI'
out_dir="adni_dod_fmri"

if [ ! -d $out_dir ]
then
	mkdir $out_dir 
fi

ls -d $data_dir/0*/*rs[f,F]MRI*/*/I*/*.nii>temp.txt
ls -d $data_dir/0*/*rs[f,F]MRI*/*/I*/*.json>>temp.txt

while read line;
do
	subid=$(echo $line| awk -F '/' '{print $9}')
	session=$(echo $line| awk -F '/' '{print $8}')
#	session=${session//-/.}	
	new_dir=$out_dir/$subid/$session/func/
	
	echo $new_dir

	if [ ! -d $new_dir ]
	then
		mkdir -p $new_dir
	fi

	#cp -l $line/*.nii $new_dir
	#cp -l $line/*.json $new_dir
	cp -l $line $new_dir

	fslinfo $line/*.nii

done < temp.txt 

#rm temp.txt
