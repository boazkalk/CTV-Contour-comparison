function plotconmat(conmat_dice,conmat_hausdorffmax,conmat_hausdorff95, specialists, nr_patients, nr_specialists, Result_dice_single_intramod, Result_hdistDmax_intramod, Result_hdistD95_intramod)
if conmat_dice==true
plotconnmat_dice(specialists, nr_patients, nr_specialists, Result_dice_single_intramod); else end
if conmat_hausdorffmax==true
plotconnmat_hausdorffmax(specialists, nr_patients, nr_specialists, Result_hdistDmax_intramod); else end
if conmat_hausdorff95==true
plotconnmat_hausdorff95(specialists, nr_patients, nr_specialists, Result_hdistD95_intramod); else end
end