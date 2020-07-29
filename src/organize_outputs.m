function organize_outputs(out_dir,rwroi_nii,roi_csv)

% PDF
system(['cd ' out_dir ' && mkdir PDF && mv mniconn.pdf PDF']);


% Unsmoothed connmaps
system(['cd ' out_dir ' && ' ...
	' mkdir ZMAPS_KEEPGM_MNI && ' ...
	' mv connmaps/Z_*_wkeepgm.nii ZMAPS_KEEPGM_MNI && ' ...
	' gzip ZMAPS_KEEPGM_MNI/*.nii']);

system(['cd ' out_dir ' && ' ...
	' mkdir ZMAPS_REMOVEGM_MNI && ' ...
	' mv connmaps/Z_*_wremovegm.nii ZMAPS_REMOVEGM_MNI && ' ...
	' gzip ZMAPS_REMOVEGM_MNI/*.nii']);


% Smoothed connmaps
%system(['cd ' out_dir ' && ' ...
%	' mkdir SZMAPS_KEEPGM_MNI && ' ...
%	' mv connmaps/sZ_*_wkeepgm.nii SZMAPS_KEEPGM_MNI && ' ...
%	' gzip SZMAPS_KEEPGM_MNI/*.nii']);
%
%system(['cd ' out_dir ' && ' ...
%	' mkdir SZMAPS_REMOVEGM_MNI && ' ...
%	' mv connmaps/sZ_*_wremovegm.nii SZMAPS_REMOVEGM_MNI && ' ...
%	' gzip SZMAPS_REMOVEGM_MNI/*.nii']);


% Conn matrix
system(['cd ' out_dir ' && mkdir RMATRIX && mv R_*.csv RMATRIX']);
system(['cd ' out_dir ' && mkdir ZMATRIX && mv Z_*.csv ZMATRIX']);


% ROI images
system(['cd ' out_dir ' && mkdir ROIS && cp ' rwroi_nii ' ROIS && ' ...
	' gzip ROIS/*.nii']);


% Extracted ROI time series
system(['cd ' out_dir ' && mkdir ROIDATA && mv roidata_*.csv ROIDATA']);


% ROI spec
system(['cd ' out_dir ' && mkdir ROILABELS && ' ...
	' cp ' roi_csv ' ROILABELS']);


