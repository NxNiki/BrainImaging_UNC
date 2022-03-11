#!/bin/sh

############################# CPAC: ###############################
working_dir='/home/xin/Downloads/BrainImaging_UNC'

# data organized in bids structure:
dataPath=$working_dir/'out02_adni_fmri_t1'
outputPath=$working_dir/'cpac_output_dir'
dataConfigPath=$working_dir/'cpac_data_config'

#configure data yml file:
#cpac utils data_config new_settings_template

docker run -i --rm --user $(id -u):$(id -g) \
-v $dataConfigPath:/scratch \
-w="/scratch" \
fcpindi/c-pac:latest 'xx' 'xx' cli -- \
utils data_config new_settings_template

# 'xx' 'xx':
# bids_dir and outputs_dir are required but not used, so any non-null string will work for those positional arguments.

# edit data setting file created in dataConfigPath before running next steps...
