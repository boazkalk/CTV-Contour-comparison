function [Result_dice_intermod_combined, Result_hdistD95_intermod_combined, Result_hdistDmax_intermod_combined] = ...
combineresults_intermod(Result_dice_intermod, Result_hdistD95_intermod, Result_hdistDmax_intermod, nr_patients)

    Result_dice_intermod_combined.O35T2vsTrue = [];
    Result_dice_intermod_combined.O35T2vs15T2 = [];
    Result_dice_intermod_combined.O35Truevs15T2 = [];
    Result_hdistD95_intermod_combined.O35T2vsTrue = [];
    Result_hdistD95_intermod_combined.O35T2vs15T2 = [];
    Result_hdistD95_intermod_combined.O35Truevs15T2 = [];
    Result_hdistDmax_intermod_combined.O35T2vsTrue = [];
    Result_hdistDmax_intermod_combined.O35T2vs15T2 = [];
    Result_hdistDmax_intermod_combined.O35Truevs15T2 = [];

    for i = 1:1:nr_patients
    patient = i;
    
    Result_dice_intermod_combined.O35T2vsTrue = [Result_dice_intermod_combined.O35T2vsTrue, Result_dice_intermod(patient).spec.O35T2vsTrue];
    Result_dice_intermod_combined.O35T2vs15T2 = [Result_dice_intermod_combined.O35T2vs15T2, Result_dice_intermod(patient).spec.O35T2vs15T2];
    Result_dice_intermod_combined.O35Truevs15T2 = [Result_dice_intermod_combined.O35Truevs15T2, Result_dice_intermod(patient).spec.O35Truevs15T2];
    Result_hdistD95_intermod_combined.O35T2vsTrue = [Result_hdistD95_intermod_combined.O35T2vsTrue, Result_hdistD95_intermod(patient).spec.O35T2vsTrue];
    Result_hdistD95_intermod_combined.O35T2vs15T2 = [Result_hdistD95_intermod_combined.O35T2vs15T2, Result_hdistD95_intermod(patient).spec.O35T2vs15T2];
    Result_hdistD95_intermod_combined.O35Truevs15T2 = [Result_hdistD95_intermod_combined.O35Truevs15T2, Result_hdistD95_intermod(patient).spec.O35Truevs15T2];
    Result_hdistDmax_intermod_combined.O35T2vsTrue = [Result_hdistDmax_intermod_combined.O35T2vsTrue, Result_hdistDmax_intermod(patient).spec.O35T2vsTrue];
    Result_hdistDmax_intermod_combined.O35T2vs15T2 = [Result_hdistDmax_intermod_combined.O35T2vs15T2, Result_hdistDmax_intermod(patient).spec.O35T2vs15T2];
    Result_hdistDmax_intermod_combined.O35Truevs15T2 = [Result_hdistDmax_intermod_combined.O35Truevs15T2, Result_hdistDmax_intermod(patient).spec.O35Truevs15T2];

    end

end

