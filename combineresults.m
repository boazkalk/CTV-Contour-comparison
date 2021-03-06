%%%%%%%%%%%%%%%%%%%%%%%
% Boaz Kalkhoven 2022 %
%%%%%%%%%%%%%%%%%%%%%%%

function [Result_dice_combined_single, Result_dice_combined_mismatch, Result_hdistD95_combined, Result_hdistmax_combined] = combineresults(nr_patients, Result_dice_single, Result_dice_mismatch, ...
    Result_hdistD95, Result_hdistDmax)

%     data of all patients combined
%     Example:
%         Result_dice_combined_single
%             -> Modality
%                 -> Dice coefficients between observers of all patients

    Result_dice_combined_single.mod035True = [];
    Result_dice_combined_single.mod15T2 = [];

    Result_dice_combined_mismatch.mod035True = [];
    Result_dice_combined_mismatch.mod15T2 = [];

    Result_hdistD95_combined.mod035True = [];
    Result_hdistD95_combined.mod15T2 = [];

    Result_hdistmax_combined.mod035True = [];
    Result_hdistmax_combined.mod15T2 = [];
    
    for i = 1:1:nr_patients
    patient = i;
    
    Result_dice_combined_single.mod035True = [Result_dice_combined_single.mod035True, Result_dice_single(patient).mod(1).dice];
    Result_dice_combined_single.mod15T2 = [Result_dice_combined_single.mod15T2, Result_dice_single(patient).mod(2).dice];
    
    Result_dice_combined_mismatch.mod035True = [Result_dice_combined_mismatch.mod035True, Result_dice_mismatch(patient).mod(1).dice];
    Result_dice_combined_mismatch.mod15T2 = [Result_dice_combined_mismatch.mod15T2, Result_dice_mismatch(patient).mod(2).dice];
    
    Result_hdistD95_combined.mod035True = [Result_hdistD95_combined.mod035True, Result_hdistD95(patient).mod(1).D95];
    Result_hdistD95_combined.mod15T2 = [Result_hdistD95_combined.mod15T2, Result_hdistD95(patient).mod(2).D95];
    
    Result_hdistmax_combined.mod035True = [Result_hdistmax_combined.mod035True, Result_hdistDmax(patient).mod(1).Dmax];
    Result_hdistmax_combined.mod15T2 = [Result_hdistmax_combined.mod15T2, Result_hdistDmax(patient).mod(2).Dmax];
    end

end

