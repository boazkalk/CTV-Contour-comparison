clear all
close all

plotresults = 1;

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

% Calculate the inter modality volume dice coefficient
Result_dice_single = Dice3Dresults(Proc_Pat_delin, nr_patients, nr_mod,nr_specialists);

% Calculate the CTV mismatch
Result_dice_mismatch = dice_mismatch(Proc_Pat_delin, nr_patients, nr_mod, nr_specialists);

% Calculate max + 95th percentile hausdorff distance 
[Result_hdistD95, Result_hdistDmax] = hausdorff_dist(Proc_Pat_delin, nr_patients, nr_mod, nr_specialists);

%% Plot results Patients solo
if plotresults == true
    for i = 1:1:nr_patients
    patient = i;
    tempdicesingle = transpose(table2array(struct2table(Result_dice_single(patient).mod)));
    figure()
    boxplot((tempdicesingle),'Labels',{'0.35T2','0.35TrueFi','1.5T2'})
    title(['Dice, Patient = ' num2str(patient)])
    
    temphdist95 = transpose(table2array(struct2table(Result_hdistD95(patient).mod)));
    figure()
    boxplot((temphdist95),'Labels',{'0.35T2','0.35TrueFi','1.5T2'})
    title(['Hdorff95, Patient = ' num2str(patient)])
    
    temphdistmax = transpose(table2array(struct2table(Result_hdistDmax(patient).mod)));
    figure()
    boxplot((temphdistmax),'Labels',{'0.35T2','0.35TrueFi','1.5T2'})
    title(['Hdorffmax, Patient = ' num2str(patient)])

    clear tempdicesingle temphdist95 temphdistmax
    end
else
end

%% Results Patients together
[Result_dice_combined_single, Result_dice_combined_mismatch, Result_hdistD95_combined, Result_hdistmax_combined] = combineresults(nr_patients, Result_dice_single, Result_dice_mismatch, ...
    Result_hdistD95, Result_hdistDmax);

%% Plot results Patients combined
if plotresults == true
    tempdicecombined = [transpose(Result_dice_combined_single.mod035T2),transpose(Result_dice_combined_single.mod035True),transpose(Result_dice_combined_single.mod15T2)];
    figure()
    boxplot((tempdicecombined),'Labels',{'0.35T2','0.35TrueFi','1.5T2'})
    title(['Combined dice single'])

    tempdicecombinedmism = [transpose(Result_dice_combined_mismatch.mod035T2),transpose(Result_dice_combined_mismatch.mod035True),transpose(Result_dice_combined_mismatch.mod15T2)];
    figure()
    boxplot((tempdicecombinedmism),'Labels',{'0.35T2','0.35TrueFi','1.5T2'})
    title(['Combined dice mismatch'])

    temphdist95 = [transpose(Result_hdistD95_combined.mod035T2),transpose(Result_hdistD95_combined.mod035True),transpose(Result_hdistD95_combined.mod15T2)];
    figure()
    boxplot((temphdist95),'Labels',{'0.35T2','0.35TrueFi','1.5T2'})
    title(['Combined hausdorff 95th'])

    temphdistmax = [transpose(Result_hdistmax_combined.mod035T2),transpose(Result_hdistmax_combined.mod035True),transpose(Result_hdistmax_combined.mod15T2)];
    figure()
    boxplot((temphdistmax),'Labels',{'0.35T2','0.35TrueFi','1.5T2'})
    title(['Combined hausdorff max'])

    clear tempdicecombinedmism tempdicecombined temphdistmax temphdist95
else
end

