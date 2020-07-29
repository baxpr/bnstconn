# mniconn

Computes functional connectivity maps and matrices for a specified set of ROIs.

## Inputs

- Preprocessed fMRI data from [connprep](https://github.com/baxpr/connprep)
- ROI image (the name of an image within the container)
- Bias-corrected MNI space T1 image from cat12_ndw, or other MNI T1

## Pipeline

- Resample the ROI image to match the fMRI. It's assumed both are already aligned and in MNI space.

- 