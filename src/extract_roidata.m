function roidata = extract_roidata(wfmri_nii,rwroi_nii,roi_csv,out_dir,tag)

% Load and count ROIs from the image
Vroi = spm_vol(rwroi_nii);
Yroi = spm_read_vols(Vroi);
Yroi(isnan(Yroi(:))) = 0;
roi_vals = unique(Yroi(:));
roi_vals = roi_vals(roi_vals~=0);

% Load the normalized ROI label file
roi_info = readtable(roi_csv);

% Check for a problem situation
if ~all(sort(roi_vals) == sort(roi_info.Label))
	error('ROI labels in label file do not match image file')
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
writetable(roidata,roidata_csv);

return

