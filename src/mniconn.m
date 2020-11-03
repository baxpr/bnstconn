function mniconn(varargin)


%% Parse inputs
P = inputParser;

% ROI file - must be in src/rois and have matching -label.csv with ROI
% names. Must be MNI space
addOptional(P,'wroi_niigz','ABHHIP_LR.nii.gz')

% Preprocessed fMRI, outputs from connprep. MNI space only
addOptional(P,'wremovegm_niigz','../INPUTS/filtered_removegm_noscrub_wadfmri.nii.gz');
addOptional(P,'wkeepgm_niigz','../INPUTS/filtered_keepgm_noscrub_wadfmri.nii.gz');
addOptional(P,'wmeanfmri_niigz','../INPUTS/wmeanadfmri.nii.gz');

% Useful masks from connprep
addOptional(P,'wbrainmask_niigz','../INPUTS/rwmask.nii.gz');

% Bias corrected T1 from cat12
addOptional(P,'wt1_niigz','../INPUTS/wmt1.nii.gz');

% Smoothing to apply to connectivity maps
addOptional(P,'fwhm','6');

% Subject info if on XNAT
addOptional(P,'project','UNK_PROJ');
addOptional(P,'subject','UNK_SUBJ');
addOptional(P,'session','UNK_SESS');
addOptional(P,'scan','UNK_SCAN');

% Change paths to match test environment if needed
addOptional(P,'magick_path','/usr/bin');
addOptional(P,'src_path','/opt/mniconn/src');
addOptional(P,'fsl_path','/usr/local/fsl/bin');

% Where to store outputs
addOptional(P,'out_dir','../OUTPUTS');

% Parse
parse(P,varargin{:});
disp(P.Results)


%% Process
mniconn_main(P.Results);


%% Exit
if isdeployed
	exit
end

