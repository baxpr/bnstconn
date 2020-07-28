#!/bin/bash

function connmap {
	# 1 IMG
	# 2 name
	# 3-5 x,y,z
	# connmap sZ_LHIPP_wremovegm.nii hipp -25 -20 -16

	freeview \
	  -v ${OUT}/wt1.nii \
	  -v ${OUT}/${1}:colormap=heat:heatscale=90,95,100:percentile=true \
	  -viewsize 400 400 --layout 1 --zoom 1.3 --viewport sagittal \
	  -ras ${3} -18 18 \
	  -ss conn_mni_${2}_sag.png

  	freeview \
  	  -v ${OUT}/wt1.nii \
  	  -v ${OUT}/${1}:colormap=heat:heatscale=90,95,100:percentile=true \
  	  -viewsize 400 400 --layout 1 --zoom 1.3 --viewport coronal \
  	  -ras 0 ${4} 18 \
  	  -ss conn_mni_${2}_cor.png

	freeview \
	  -v ${OUT}/wt1.nii \
	  -v ${OUT}/${1}:colormap=heat:heatscale=90,95,100:percentile=true \
	  -viewsize 400 400 --layout 1 --zoom 1.3 --viewport axial \
	  -ras 0 -18 ${5} \
	  -ss conn_mni_${2}_axi.png

	montage -mode concatenate \
	  conn_mni_${2}_sag.png conn_mni_${2}_cor.png conn_mni_${2}_axi.png \
	  -tile 3x -quality 100 -background black -gravity center \
	  -border 10 -bordercolor black conn_mni_${2}.png

}

cd ${OUT}

connmap connmaps/Z_BNST_L_removegm.nii BNST_L -6 3 0
connmap connmaps/Z_BNST_R_removegm.nii BNST_R 6 3 0

montage -mode concatenate \
  conn_mni_BNST_L.png conn_mni_BNST_R.png \
  -tile 1x -quality 100 -background black -gravity center \
  -border 10 -bordercolor white conn_mni.png

