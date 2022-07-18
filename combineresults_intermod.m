%%%%%%%%%%%%%%%%%%%%%%%
% Boaz Kalkhoven 2022 %
%%%%%%%%%%%%%%%%%%%%%%%

function [Result_intermod_combined_perspec, Result_intermod_combined_total] = ...
combineresults_intermod(Result_dice_intermod, Result_hdistD95_intermod, Result_hdistDmax_intermod, nr_patients)
    
%     Result_intermod_combined_perspec
%         -> Metrics
%             -> Rows: specialists, Columns: patients
%     
%     Result_intermod_combined_perspec
%         -> Metrics
%             -> All metric values

    tdice = [];
    thdorff95 = [];
    thdorffmax = [];

    for i = 1:1:nr_patients
        patient = i;
        tdice = [tdice, table2array(struct2table(Result_dice_intermod(patient).spec))];
        thdorff95 = [thdorff95, table2array(struct2table(Result_hdistD95_intermod(patient).spec))];
        thdorffmax = [thdorffmax, table2array(struct2table(Result_hdistDmax_intermod(patient).spec))];
    end
    Result_intermod_combined_perspec.dice = tdice;
    Result_intermod_combined_perspec.hdorff95 = thdorff95;
    Result_intermod_combined_perspec.hdorffmax = thdorffmax;

    tdice = [];
    thdorff95 = [];
    thdorffmax = [];

    for i = 1:1:nr_patients
    patient = i;
    
    tdice = [tdice, transpose(table2array(struct2table(Result_dice_intermod(patient).spec)))];
    thdorff95 = [thdorff95, transpose(table2array(struct2table(Result_hdistD95_intermod(patient).spec)))];
    thdorffmax = [thdorffmax, transpose(table2array(struct2table(Result_hdistDmax_intermod(patient).spec)))];

    end
    
    Result_intermod_combined_total.dice = tdice;
    Result_intermod_combined_total.hdorff95 = thdorff95;
    Result_intermod_combined_total.hdorffmax = thdorffmax;
    

end

