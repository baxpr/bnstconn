function [roidata,roi_csv] = extract_roidata(wfmri_nii,rwroi_nii,roi_csv,out_dir,tag)

% Load and count ROIs from the image
Vroi = spm_vol(rwroi_nii);
Yroi = spm_read_vols(Vroi);
roi_vals = unique(Yroi(:));
roi_vals = roi_vals(roi_vals~=0);

% Load the ROI label file. Label the first two columns as Label and Region
% if matlab detects them as unlabeled.
roi_info = readtable(roi_csv);
if strcmp(roi_info.Properties.VariableNames{1},'Var1')
	roi_info.Properties.VariableNames{'Var1'} = 'Label';
	roi_info.Properties.VariableNames{'Var2'} = 'Region';
end

% If we got a slant STATS output, rename the appropriate columns
indR = strcmp(roi_info.Properties.VariableNames,'LabelName_BrainCOLOR_');
indL = strcmp(roi_info.Properties.VariableNames,'LabelNumber_BrainCOLOR_');
if sum(indR)==1 && sum(indL)==1
	roi_info.Properties.VariableNames{indR} = 'Region';
	roi_info.Properties.VariableNames{indL} = 'Label';
end

% Normalize ROI names
for h = 1:height(roi_info)
	roi_info.Region{h} = sprintf('r%04d_%s', ...
		roi_info.Label(h),regexprep(roi_info.Region{h},{'[%() ]+','_+$'},{'_', ''}));
end

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
outcsv = roidata_csv(:,{'Label','Region'});
writetable(roidata,outcsv)

% Save updated ROI info
[~,n,e] = fileparts(roi_csv);
roi_csv = fullfile(out_dir,[n e]);
writetable(roi_info,roi_csv)

return

