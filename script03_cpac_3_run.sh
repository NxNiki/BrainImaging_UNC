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
fcpindi/c-pac:latest $dataPath $outputPath participant \
--data_config_file $dataSettingPath/data_config_data_config_adni.yml \
--save_working_dir

