clear all
close all

%%
plotresults_solo = 1;
plotresults_comb = 1;
plotresults_solo_intermod = 1;
plotresults_comb_intermod = 1;
plotresults_vol = 1;
plotresults_vol_comb = 1;

%% Set up data and code folder
% The delineation data path has to have the following set up:
% Data folder -> Patients -> Modalities -> Specialists
folderpath = 'C:\School\Master\Stage\Matlab\testdata-echt';
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

%%
mask = Proc_Pat_delin.mod(1).specialist(1).TDmask;
folderpath = 'C:\School\Master\Stage\Matlab\testdata-echt\PAT1\0.35T2\HPN';
temp_nr_patients = struct2cell(dir(folderpath));
temp_nr_patients = sort(temp_nr_patients(1,:));
j=1;
image=[];
for i=3:1:length(temp_nr_patients)-1
    disp(strcat(folderpath,'\',temp_nr_patients{1,i}));
    slice = dicomread(dicominfo(strcat(folderpath,'\',temp_nr_patients{1,i})));
    image(:,:,j) = slice;
    j=j+1;
end
%volumeViewer(mask);
volumeViewer(image);
%volumeViewer(image, mask);

%% Volume calculation of tumors
Tumorvolumes = calctumorvolume(Proc_Pat_delin, nr_patients, nr_mod,nr_specialists);

% Plot volume results
plotvolumes(Tumorvolumes,plotresults_vol,plotresults_vol_comb,nr_patients);

%% Intra modality results

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

%% Plot results Patients solo intramod
plotressolo(plotresults_solo,Result_dice_single_intramod,Result_hdistD95_intramod,Result_hdistDmax_intramod,nr_patients);

%% Plot results Patients combined intramod
plotrescomb(plotresults_comb,Result_dice_combined_single_intramod,Result_dice_combined_mismatch_intramod,Result_hdistD95_combined_intramod ...
    ,Result_hdistmax_combined_intramod);

%% Inter modality results

% Calculate the inter modality, intra specialist volume dice coefficient
Result_dice_intermod = Dice3Dresults_intermod(Proc_Pat_delin, nr_patients, nr_mod,nr_specialists);

% Calculate max + 95th percentile hausdorff distance, intra specialist,
% inter modality 
[Result_hdistD95_intermod, Result_hdistDmax_intermod] = hausdorff_dist_intermod(Proc_Pat_delin, nr_patients, nr_mod, nr_specialists);

% Results Patients together
[Result_dice_intermod_combined, Result_hdistD95_intermod_combined, Result_hdistDmax_intermod_combined] = ...
combineresults_intermod(Result_dice_intermod, Result_hdistD95_intermod, Result_hdistDmax_intermod, nr_patients);

%% Plot results Patients solo intermodality
plotressolo_intermod(plotresults_solo_intermod,Result_dice_intermod,Result_hdistD95_intermod,Result_hdistDmax_intermod,nr_patients)

% Plot results patients combined intermod
plotrescomb_intermod(plotresults_comb_intermod, Result_dice_intermod_combined, Result_hdistD95_intermod_combined, Result_hdistDmax_intermod_combined);

