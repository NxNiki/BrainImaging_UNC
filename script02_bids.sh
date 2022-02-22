#! bin/sh

## create bids file structure for rsfMRI data:

if [ ! -d "adni_bids" ]
then
	mkdir adni_bids
fi

while read line;
do
	subid=$(echo $line| awk -F '/' '{print $9}')
	session=$(echo $line| awk -F '/' '{print $8}')
#	session=${session//-/.}	
	new_dir=adni_bids/$subid/$session/func/
	
	echo $new_dir

	if [ ! -d $new_dir ]
	then
		mkdir -p $new_dir
	fi

	cp -l $line/*.nii $new_dir
	cp -l $line/*.json $new_dir

done < out01_rsfmri_dir3.txt 
