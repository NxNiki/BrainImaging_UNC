#!/bin/sh

############################# CPAC: ###############################
working_dir='/home/xin/Downloads/BrainImaging_UNC'

# data organized in bids structure:
dataPath=$working_dir/'out02_adni_fmri_t1'
outputPath=$working_dir/'cpac_output_dir'
dataSettingPath=$working_dir/'cpac_data_config'

#configure data yml file:
#cpac utils data_config new_settings_template

docker run -i --rm --user $(id -u):$(id -g) \
-v $dataPath:$dataPath \
-v $outputPath:$outputPath \
-v $dataSettingPath:$dataSettingPath \
-v $sataSettingPath:/scratch \
-w"/scratch" \
fcpindi/c-pac:latest $dataPath $outputPath cli -- utils \
data_config build $dataSettingPath/data_settings.yml



###################### DPARSFA/DPABISurf: #########################
#freeSurferLicense='/ram/USERS/xin/license.txt'
#dataPath='/ram/USERS/xin/BrainImaging_UNC/out02_adni_dod_mri'
#
#docker run -it --rm \ 
#-v $freeSurferLicense:/opt/freesurfer/license.txt \
#-v $dataPath:/data \ 
#cgyan/dpabi /bin/bash /opt/DPABI/DPABI_StandAlone/run_DPABISurf_run_StandAlone.sh ${MCRPath} /data/DPABISurf_Cfg.mat
