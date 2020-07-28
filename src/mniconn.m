function mniconn(varargin)


%% Parse inputs
P = inputParser;

% ROI file - must be in src/rois and have matching -label.csv with ROI
% names
addOptional(P,'roi_niigz','BNST_LR.nii.gz')

% Preprocessed fMRI, outputs from connprep
addOptional(P,'removegm_niigz','/INPUTS/fmri.nii.gz');
addOptional(P,'keepgm_niigz','/INPUTS/fmri.nii.gz');
addOptional(P,'meanfmri_niigz','/INPUTS/meanadfmri.nii.gz');
addOptional(P,'wremovegm_niigz','/INPUTS/fmri.nii.gz');
addOptional(P,'wkeepgm_niigz','/INPUTS/fmri.nii.gz');
addOptional(P,'wmeanfmri_niigz','/INPUTS/wmeanadfmri.nii.gz');

% Useful masks from connprep
addOptional(P,'wedge_niigz','/INPUTS/redge_wgray.nii.gz');
addOptional(P,'wbrainmask_niigz','/INPUTS/rwmask.nii.gz');

% Bias corrected T1s and deformation field from cat12
addOptional(P,'t1_niigz','/INPUTS/mt1.nii.gz');
addOptional(P,'wt1_niigz','/INPUTS/wmt1.nii.gz');
addOptional(P,'invdef_niigz','/INPUTS/iy_t1.nii.gz');

% Smoothing to apply to connectivity maps
addOptional(P,'fwhm','6');

% Subject info if on XNAT
addOptional(P,'project','UNK_PROJ');
addOptional(P,'subject','UNK_SUBJ');
addOptional(P,'session','UNK_SESS');
addOptional(P,'scan','UNK_SCAN');

% Change paths to match test environment if needed
addOptional(P,'magick_path','/usr/bin');
addOptional(P,'src_path','/opt/fsthalconnMNI/src');
addOptional(P,'fsl_path','/usr/local/fsl/bin');

% Where to store outputs
addOptional(P,'out_dir','/OUTPUTS');

% Parse
parse(P,varargin{:});
disp(P)


%% Process
fsthalconnMNI_main( ...
	out_dir,subject_dir,roiinfo_csv, ...
	removegm_niigz,keepgm_niigz,wremovegm_niigz,wkeepgm_niigz, ...
	wedge_niigz,wbrainmask_niigz, ...
	wmeanfmri_niigz,meanfmri_niigz,t1_niigz,wt1_niigz,invdef_niigz, ...
	fwhm, ...
	project,subject,session,scan, ...
	magick_path,src_path,fsl_path ...
	);


%% Exit
if isdeployed
	exit
end

