function [wremovegm_nii,wkeepgm_nii,wmeanfmri_nii,wt1_nii,wroi_nii,roi_csv] ...
	= prep_files(inp)

% Terrible hack with eval again to copy files to out_dir and unzip
for tag = {'wremovegm','wkeepgm','wbrainmask','wmeanfmri','wt1'}
	copyfile(eval(['inp.' tag{1} '_niigz']),[inp.out_dir '/' tag{1} '.nii.gz']);
	system(['gunzip -f ' inp.out_dir '/' tag{1} '.nii.gz']);
	cmd = [tag{1} '_nii = [inp.out_dir ''/'' tag{1} ''.nii''];'];
	eval(cmd);
end

% And we'll grab the ROI file separately
[p,n,e] = fileparts(inp.wroi_niigz);

if isempty(p)
	% Use an ROI file from container if no path provided
	copyfile(which(inp.wroi_niigz),inp.out_dir);
	system(['gunzip -f ' inp.out_dir '/' inp.wroi_niigz]);
	wroi_nii = strrep(fullfile(inp.out_dir,inp.wroi_niigz),'.gz','');
	[~,n2] = fileparts(wroi_nii);
	roi_csv = [n2 '-labels.csv'];
	copyfile(which(roi_csv),inp.out_dir);
	roi_csv = fullfile(inp.out_dir,roi_csv); 
else
	% Otherwise use externally supplied ROI file
	copyfile(inp.wroi_niigz,inp.out_dir);
	system(['gunzip -f ' inp.out_dir '/' n e]);
	wroi_nii = fullfile(inp.out_dir,n);
	copyfile(inp.wroilabel_csv,inp.out_dir);
	[~,n3,e3] = fileparts(inp.wroilabel_csv);
	roi_csv = fullfile(inp.out_dir,[n3 e3]);
end
