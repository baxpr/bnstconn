#!/usr/bin/env bash

# ROIs on t1 and mean fmri, axial slices +x / -y mm from center of mass of mean fmri

# FSL init
PATH=${FSLDIR}/bin:${PATH}
. ${FSLDIR}/etc/fslconf/fsl.sh

# Work in output directory
cd ${OUT}

# Find center of mass of mean fmri
com=$(fslstats wmeanfmri -c)
XYZ=(${maskcom// / })

# Axial slices to show, relative to COM in mm
for sl in -40 -30 -20 -10 +0 +10 +20 +30 +40 +50 +60; do
    fsleyes render -of slice_${sl}.png \
        --scene ortho --worldLoc ${XYZ[0]} ${XYZ[1]} $(echo "${XYZ[2]} + ${sl}" | bc -l) \
        --layout horizontal --hideCursor --hideLabels --hidex --hidey \
        wmeanfmri --overlayType volume \
        roi --overlayType label --lut random_big --outline --outlineWidth 2
done

