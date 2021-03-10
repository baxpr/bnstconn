#!/bin/bash

singularity run --contain --cleanenv \
--home $(pwd)/INPUTS \
--bind INPUTS:/INPUTS \
--bind OUTPUTS:/OUTPUTS \
baxpr-mniconn-master-v3.0.0.simg \
wroi_niigz /INPUTS/rois_PMAT.nii.gz \
wroilabel_csv rois_PMAT-labels.csv \
wremovegm_niigz /INPUTS/filtered_removegm_noscrub_wadfmri.nii.gz \
wkeepgm_niigz /INPUTS/filtered_keepgm_noscrub_wadfmri.nii.gz \
wmeanfmri_niigz /INPUTS/wmeanadfmri.nii.gz \
wbrainmask_niigz /INPUTS/rwmask.nii.gz \
wt1_niigz /INPUTS/wmt1.nii.gz \
connmaps_out no \
out_dir /OUTPUTS

