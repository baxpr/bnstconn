function conncompute(roidata,fmri_nii,out_dir,tag)

%% Connectivity matrix
R = corr(table2array(roidata));
Z = atanh(R) * sqrt(size(roidata,1)-3);
R = array2table(R);
Z = array2table(Z);
R.Properties.VariableNames = roidata.Properties.VariableNames;
R.Properties.RowNames = roidata.Properties.VariableNames;
Z.Properties.VariableNames = roidata.Properties.VariableNames;
Z.Properties.RowNames = roidata.Properties.VariableNames;
writetable(R,fullfile(out_dir,['R_' tag '.csv']),'WriteRowNames',true);
writetable(Z,fullfile(out_dir,['Z_' tag '.csv']),'WriteRowNames',true);


%% Connectivity maps
connmap_dir = [out_dir '/connmaps'];
mkdir(connmap_dir);

% Load fmri
Vfmri = spm_vol(fmri_nii);
Yfmri = spm_read_vols(Vfmri);
osize = size(Yfmri);
rYfmri = reshape(Yfmri,[],osize(4))';

% Compute connectivity maps
Rmap = corr(table2array(roidata),rYfmri);
Zmap = atanh(Rmap) * sqrt(size(roidata,1)-3);

% Save maps to file, original and smoothed versions
for r = 1:width(roidata)

	Vout = rmfield(Vfmri(1),'pinfo');
	Vout.fname = fullfile(connmap_dir, ...
		['Z_' roidata.Properties.VariableNames{r} '_' tag '.nii']);
	Yout = reshape(Zmap(r,:),osize(1:3));
	Vout = spm_write_vol(Vout,Yout);
	
%	sfname = fullfile(conn_dir, ...
%		['sZ_' roidata.Properties.VariableNames{r} '_' tag '.nii']);
%	spm_smooth(Vout,sfname,str2double(fwhm));
	
end

