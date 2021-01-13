function roidata = extract_roidata(wfmri_nii,rwroi_nii,roi_csv,out_dir,tag)

% Load and count ROIs
Vroi = spm_vol(rwroi_nii);
Yroi = spm_read_vols(Vroi);
roi_vals = unique(Yroi(:));
roi_vals = roi_vals(roi_vals~=0);

% Check against ROI label file. Label columns if matlab detects them as
% unlabeled. If labeled, need to be Label and Region.
roi_info = readtable(roi_csv);
if strcmp(roi_info.Properties.VariableNames{1},'Var1')
	roi_info.Properties.VariableNames{'Var1'} = 'Label';
	roi_info.Properties.VariableNames{'Var2'} = 'Region';
end

% Check for a couple of problem situations
if ~all(sort(roi_vals) == sort(roi_info.Label))
	error('ROI labels in label file do not match image file')
end
if numel(roi_vals) ~= numel(unique(roi_vals))
	error('ROI label values must be unique')
end

% If ROI names aren't unique, make them so
if numel(roi_info.Region) ~= numel(unique(roi_info.Region))
	for h = 1:height(roi_info)
		roi_info.Region{h} = sprintf('r%04d_%s', ...
			roi_info.Label(h),roi_info.Region{h});
	end
end

% Load fmri and reshape to time x voxel
Vfmri = spm_vol(wfmri_nii);
Yfmri = spm_read_vols(Vfmri);
Yfmri = reshape(Yfmri,[],size(Yfmri,4))';

% Extract mean time series
roidata = table();
for r = 1:height(roi_info)
	voxelinds = Yroi(:)==roi_info.Label(r);
	voxeldata = Yfmri(:,voxelinds);
	roidata.(roi_info.Region{r})(:,1) = mean(voxeldata,2);
end
roidata.Properties.VariableNames = roi_info.Region(:)';

% Save ROI data to file
roidata_csv = [out_dir '/roidata_' tag '.csv'];
writetable(roidata,roidata_csv)

return

