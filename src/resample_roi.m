function rwroi_nii = resample_roi(wroi_nii,wmeanfmri_nii)

% Params. Critically, 0 order (nearest neighbor) interpolation
flags = struct('mask',true,'mean',false,'interp',0,'which',1, ...
	'wrap',[0 0 0],'prefix','r');

% Use SPM to reslice
spm_reslice_quiet({wmeanfmri_nii wroi_nii},flags);

% Figure out the new filename
[p,n,e] = fileparts(wroi_nii);
rwroi_nii = fullfile(p,['r' n e]);
