clear all
close all

%%
plotresults_solo = 0;
plotresults_comb = 0;

%% Set up data and code folder
% The delineation data path has to have the following set up:
% Data folder -> Patients -> Modalities -> Specialists
folderpath = 'C:\School\Master\Stage\Matlab\testdata';
temp_nr_patients = struct2cell(dir(folderpath));
[~,nr_patients] = size(find(contains(temp_nr_patients(1,:),'PAT')));

% Modalities for this study are 0.35T T2 & Truefi and the 1.5T T2
mod = ["0.35T2" "0.35Truefi" "1.5T2"];
nr_mod = length(mod);

% Radiotherapists' abbreviations
specialists = ["HPN" "PTN" "TBO" "STR"];
nr_specialists = length(specialists);

% Parse the information of the RTSTRUCT files and put in a data struct
Pat_delin = parsetotal(folderpath, nr_patients, mod, specialists);
% Get 2D masks from the contours 
Pat_delin = getmasks(Pat_delin,nr_patients, nr_mod,nr_specialists);
% Put all masks in the right order wrt slice number in the total volume
Pat_delin = sortimagenr_masks(Pat_delin, nr_patients, nr_mod,nr_specialists);
% Remove double contours by adding them together
Proc_Pat_delin = removedoubles(Pat_delin, nr_patients,nr_mod,nr_specialists);
% Combine the 2D contours in a 3D volume
Proc_Pat_delin = add3dvol(Proc_Pat_delin, nr_patients,nr_mod,nr_specialists);

% Calculate the inter specialist, intra modality volume dice coefficient
Result_dice_single_intramod = Dice3Dresults(Proc_Pat_delin, nr_patients, nr_mod,nr_specialists);

% Calculate the CTV mismatch
Result_dice_mismatch_intramod = dice_mismatch(Proc_Pat_delin, nr_patients, nr_mod, nr_specialists);

% Calculate max + 95th percentile hausdorff distance, inter specialist,
% intra modality
[Result_hdistD95_intramod, Result_hdistDmax_intramod] = hausdorff_dist(Proc_Pat_delin, nr_patients, nr_mod, nr_specialists);

% Results Patients together
[Result_dice_combined_single_intramod, Result_dice_combined_mismatch_intramod, Result_hdistD95_combined_intramod,... 
    Result_hdistmax_combined_intramod] = combineresults(nr_patients, Result_dice_single_intramod, Result_dice_mismatch_intramod, ...
    Result_hdistD95_intramod, Result_hdistDmax_intramod);

%% Plot results Patients solo
plotressolo(plotresults_solo,Result_dice_single,Result_hdistD95,Result_hdistDmax,nr_patients);

%% Plot results Patients combined
plotrescomb(plotresults_comb,Result_dice_combined_single,Result_dice_combined_mismatch,Result_hdistD95_combined,Result_hdistmax_combined);

%% Inter modality results

% Calculate the inter modality, intra specialist volume dice coefficient
Result_dice_intermod = Dice3Dresults_intermod(Proc_Pat_delin, nr_patients, nr_mod,nr_specialists);

% Calculate max + 95th percentile hausdorff distance, intra specialist,
% inter modality 
[Result_hdistD95_intermod, Result_hdistDmax_intermod] = hausdorff_dist_intermod(Proc_Pat_delin, nr_patients, nr_mod, nr_specialists);