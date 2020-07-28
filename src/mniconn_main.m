function mniconn_main(P)

% Unzip images and copy to working location
disp('File prep   -----------------------------------------------------------------------')
[wremovegm_nii,wkeepgm_nii,wedge_nii,wbrainmask_nii,wmeanfmri_nii,wt1_nii,wroi_nii,roi_csv] ...
	= prep_files(P);

% SPM init
spm_jobman('initcfg');

% Resample ROI image to fMRI space
disp('ROI operations   ------------------------------------------------------------------')
rwroi_nii = resample_roi(wroi_nii,wmeanfmri_nii);

% Extract ROI time series from preprocessed fMRI
roidata_removegm = extract_roidata(wremovegm_nii,rwroi_nii,roi_csv,'removegm');
roidata_keepgm = extract_roidata(wkeepgm_nii,rwroi_nii,roi_csv,'keepgm');

% Compute connectivity maps and matrices
disp('Connectivity   --------------------------------------------------------------------')
[connmap_removegm,connmat_removegm] = conncompute(roidata_removegm,wremovegm_nii,'removegm');
[connmap_keepgm,connmat_keepgm] = conncompute(roidata_keepgm,wkeepgm_nii,'keepgm');


% Smooth connectivity maps (?)

% Mask MNI space connectivity maps (leniently) to reduce disk usage

% Generate PDF report

% Organize and clean up


% Mask MNI space connectivity maps (leniently) to reduce disk usage
disp('Mask MNI results   ----------------------------------------------------------------')
mask_mni(out_dir);

% Generate PDF report
disp('Make PDF   ------------------------------------------------------------------------')
make_pdf(out_dir,t1_nii,wmeanfmri_nii,wt1_nii,magick_path,src_path,fsl_path, ...
	project,subject,session,scan);

% Organize and clean up
disp('Organize outputs   ----------------------------------------------------------------')
organize_outputs(out_dir,roiinfo_csv);

