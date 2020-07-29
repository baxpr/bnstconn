# mniconn

Computes functional connectivity maps and matrices for a specified set of ROIs.

## Inputs

- Preprocessed fMRI data from [connprep](https://github.com/baxpr/connprep)
- ROI image (the name of an image within the container)
- Bias-corrected MNI space T1 image from cat12_ndw, or other MNI T1

## Pipeline

- Resample the ROI image to match the fMRI. It's assumed both are already aligned and in MNI space.
- Extract mean time series from the supplied fMRI for each ROI in the ROI image.
- Compute functional connectivity: `R`, the correlation coefficient; and `Z`, the Fisher transformed correlation, `atanh(R) * sqrt(N-3)` where `N` is number of time points. The ROI-to_ROI matrix is computed, and also voxelwise connectivity maps.
- Generate a PDF report and organize outputs for XNAT.

