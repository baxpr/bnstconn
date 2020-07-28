function [wremovegm_nii,wkeepgm_nii,wedge_nii,wbrainmask_nii,wmeanfmri_nii,wt1_nii,wroi_nii,roi_csv] ...
	= prep_files(P)

% Terrible hack with eval again to copy files to out_dir and unzip
for tag = {'wremovegm','wkeepgm','wedge','wbrainmask','wmeanfmri','wt1'}
	copyfile(eval(['P.' tag{1} '_niigz']),[P.out_dir '/' tag{1} '.nii.gz']);
	system(['gunzip -f ' P.out_dir '/' tag{1} '.nii.gz']);
	cmd = [tag{1} '_nii = [P.out_dir ''/'' tag{1} ''.nii''];'];
	eval(cmd);
end

% And we'll grab the ROI file separately
copyfile(P.wroi_niigz,P.out_dir);
system(['gunzip -f ' P.out_dir '/' P.wroi_niigz]);
wroi_nii = strrep(fullfile(P.outdir,P.wroi_niigz),'.gz','');
roi_csv = strrep(n,'nii','csv');
copyfile(which(roi_csv),P.out_dir);

