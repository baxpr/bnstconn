#!/bin/bash

singularity run --contain --cleanenv \
--home $(pwd)/INPUTS \
--bind INPUTS:/INPUTS \
--bind OUTPUTS:/OUTPUTS \
container.simg \
wroi_niigz ABHHIP_LR_LR.nii.gz \
wremovegm_niigz /INPUTS/filtered_removegm_noscrub_wadfmri.nii.gz \
wkeepgm_niigz /INPUTS/filtered_keepgm_noscrub_wadfmri.nii.gz \
wmeanfmri_niigz /INPUTS/wmeanadfmri.nii.gz \
wbrainmask_niigz /INPUTS/rwmask.nii.gz \
wt1_niigz /INPUTS/wmt1.nii.gz
