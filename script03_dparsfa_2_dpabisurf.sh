freeSurferLicense=/home/xin/Downloads/BrainImaging_UNC/freesurfer_license.txt
dataPath=/home/xin/Downloads/BrainImaging_UNC/out03_adni_fmri_t1_dpsfa4

docker run -d --rm -v ${freeSurferLicense}:/opt/freesurfer/license.txt -v ${dataPath}:/data -p 5925:5925 cgyan/dpabi x11vnc -forever -shared -usepw -create -rfbport 5925
