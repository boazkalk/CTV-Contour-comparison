%%%%%%%%%%%%%%%%%%%%%%%
% Boaz Kalkhoven 2022 %
%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all

%% Set up data and code folder
% The delineation data path has to have the following set up:
% Data folder -> Patients -> Modalities -> Specialists
folderpath = 'C:\School\Master\Stage\Matlab\Intekeningen_specialisten';
temp_nr_patients = struct2cell(dir(folderpath));
[~,nr_patients] = size(find(contains(temp_nr_patients(1,:),'PAT')));

% Modalities for this study are 0.35T Truefi and the 1.5T T2
mod = ["0.35Truefi" "1.5Tregistered"];
nr_mod = length(mod);
 
% Radiotherapists' abbreviations
specialists = ["HPN" "PTN" "TBO" "STR"];
nr_specialists = length(specialists);

%% Parse the information of the RTSTRUCT files and put in a data struct
Pat_delin = parsetotal(folderpath, nr_patients,mod,specialists);
% Get 2D masks from the contours 
Pat_delin = getmasks(Pat_delin,nr_patients, nr_mod,nr_specialists);
% Put all masks in the right order wrt slice number in the total volume
Pat_delin = sortimagenr_masks(Pat_delin, nr_patients, nr_mod,nr_specialists);
% Remove double contours by adding them together
Proc_Pat_delin = removedoubles(Pat_delin, nr_patients,nr_mod,nr_specialists);
% Combine the 2D contours in a 3D volume
Proc_Pat_delin = add3dvol(Proc_Pat_delin, nr_patients,nr_mod,nr_specialists);

%% Volume calculation of tumors
Tumorvolumes = calctumorvolume(Proc_Pat_delin, nr_patients, nr_mod,nr_specialists); 

%% Volume differences
Tumorvolumediff = calcvoldiff(Tumorvolumes,nr_patients,nr_specialists);

%% Intra modality results
% Calculate the inter specialist, intra modality volume dice coefficient
Result_dice_single_intramod = Dice3Dresults(Proc_Pat_delin, nr_patients, nr_mod,nr_specialists);

%% Calculate the CTV mismatch
Result_dice_mismatch_intramod = dice_mismatch(Proc_Pat_delin, nr_patients, nr_mod, nr_specialists);

%% Calculate max + 95th percentile hausdorff distance, inter specialist,
% intra modality
[Result_hdistD95_intramod, Result_hdistDmax_intramod] = hausdorff_dist(Proc_Pat_delin, nr_patients, nr_mod, nr_specialists);

%% Results Patients together
[Result_dice_combined_single_intramod, Result_dice_combined_mismatch_intramod, Result_hdistD95_combined_intramod,... 
    Result_hdistmax_combined_intramod] = combineresults(nr_patients, Result_dice_single_intramod, Result_dice_mismatch_intramod, ...
    Result_hdistD95_intramod, Result_hdistDmax_intramod);

%% Inter modality results
% Calculate the inter modality, intra specialist volume dice coefficient
Result_dice_intermod = Dice3Dresults_intermod(Proc_Pat_delin, nr_patients, nr_mod,nr_specialists);

%% Calculate max + 95th percentile hausdorff distance, intra specialist,
% inter modality 
[Result_hdistD95_intermod, Result_hdistDmax_intermod] = hausdorff_dist_intermod(Proc_Pat_delin, nr_patients, nr_mod, nr_specialists);

%% Results Patients together
[Result_intermod_combined_perspec, Result_intermod_combined_total] = combineresults_intermod(Result_dice_intermod, ...
    Result_hdistD95_intermod, Result_hdistDmax_intermod, nr_patients);

%% Plotting
close all
specialistsnr = ["1" "2" "3" "4"]; 
mods = ["0.35Trufi" "1.5T2"];

plotresults_solo = 0;
plotresults_comb = 1;
plotresults_hist = 1;
plotresults_solo_intermod = 0;
plotresults_comb_intermod = 0;
plotresults_vol = 0;
plotresults_vol_comb = 0;
plotresults_vol_diff = 0;
plotresults_vol_comb_diff = 0;
conmat_dice = 0;
conmat_hausdorffmax = 0;
conmat_hausdorff95 = 0;

% Plot volume results
plotvolumes(Tumorvolumes,plotresults_vol,plotresults_vol_comb,nr_patients,mods);
plotvoldiff(Tumorvolumediff,plotresults_vol_diff,plotresults_vol_comb_diff,nr_patients,specialistsnr)

% Plot results Patients solo intramod
plotressolo(plotresults_solo,Result_dice_single_intramod,Result_hdistD95_intramod,Result_hdistDmax_intramod,nr_patients,mods);

% Plot results Patients combin ed intramod
plotrescomb(plotresults_comb,Result_dice_combined_single_intramod,Result_dice_combined_mismatch_intramod,Result_hdistD95_combined_intramod ...
    ,Result_hdistmax_combined_intramod,mods);

% Plot connectivity matrices of dice/hausdorff
plotconmat(conmat_dice,conmat_hausdorffmax,conmat_hausdorff95, specialistsnr, nr_patients, nr_specialists, ...
    Result_dice_single_intramod, Result_hdistDmax_intramod, Result_hdistD95_intramod)

% Plot results Patients solo intermodality
plotressolo_intermod(plotresults_solo_intermod,Result_dice_intermod,Result_hdistD95_intermod,Result_hdistDmax_intermod,nr_patients)

% Plot results patients combined intermod
plotrescomb_intermod(plotresults_comb_intermod, Result_intermod_combined_perspec, Result_intermod_combined_total, specialistsnr)



