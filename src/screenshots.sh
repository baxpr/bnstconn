#!/bin/bash
#
# Create a bunch of screenshots to put in the PDF report.

export FREESURFER_HOME=/usr/local/freesurfer
. $FREESURFER_HOME/SetUpFreeSurfer.sh

# MNI space connectivity maps
ss_conn_mni.sh

# Make PDF pages
ss_combine.sh
