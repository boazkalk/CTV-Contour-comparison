%%%%%%%%%%%%%%%%%%%%%%%
% Boaz Kalkhoven 2022 %
%%%%%%%%%%%%%%%%%%%%%%%

function plotconnmat_hausdorffmax(specialists, nr_patients, nr_specialists, Result_hdistDmax_intramod)

    for j = 1:1:nr_patients
    
    patient = j;
    
    v = 1:nr_specialists;
    grid = nchoosek(v,2);
    
    tempresmat35 = eye(nr_specialists,nr_specialists);
    tempresmat15 = eye(nr_specialists,nr_specialists);
    tempres = struct([]);
    
    tempres35 = Result_hdistDmax_intramod(patient).mod(1).Dmax;
    tempres15 = Result_hdistDmax_intramod(patient).mod(2).Dmax;
    
    for t = 1:1:length(grid)
    combi = grid(t,:);
    
    tempresmat35(combi(1), combi(2)) = tempres35(t);
    tempresmat35(combi(2), combi(1)) = tempres35(t);
    
    tempresmat15(combi(1), combi(2)) = tempres15(t);
    tempresmat15(combi(2), combi(1)) = tempres15(t);
    
    end
    
    n=nr_specialists;
    L = specialists;
    
    figure()
    subplot(1,2,1)
    imagesc(tempresmat35)
    set(gca, 'XTick', 1:n); % center x-axis ticks on bins
    set(gca, 'YTick', 1:n); % center y-axis ticks on bins
    set(gca, 'XTickLabel', L); % set x-axis labels
    set(gca, 'YTickLabel', L); % set y-axis labels
    colormap('default'); % set the colorscheme
    cb = colorbar;
    title('0.35T')
    
    subplot(1,2,2)
    imagesc(tempresmat15)
    set(gca, 'XTick', 1:n); % center x-axis ticks on bins
    set(gca, 'YTick', 1:n); % center y-axis ticks on bins
    set(gca, 'XTickLabel', L); % set x-axis labels
    set(gca, 'YTickLabel', L); % set y-axis labels
    colormap('default'); % set the colorscheme
    cb = colorbar;
    title('1.5T')
    
    sgtitle(strcat('Intra modality hausdorff max, Patient = ', num2str(patient)));
    
    end
    
    mean_dice_intramod = struct([]);
    mean_dice_intramod(1).dice = zeros(1,length(grid));
    mean_dice_intramod(2).dice = zeros(1,length(grid));
    for j = 1:1:nr_patients
        mean_dice_intramod(1).dice = mean_dice_intramod(1).dice + Result_hdistDmax_intramod(j).mod(1).Dmax;
        mean_dice_intramod(2).dice = mean_dice_intramod(2).dice + Result_hdistDmax_intramod(j).mod(2).Dmax;
    end
    mean_dice_intramod(1).dice = mean_dice_intramod(1).dice/nr_patients;
    mean_dice_intramod(2).dice = mean_dice_intramod(2).dice/nr_patients;

    v = 1:nr_specialists;
    grid = nchoosek(v,2);
    
    tempresmat35 = eye(nr_specialists,nr_specialists);
    tempresmat15 = eye(nr_specialists,nr_specialists);
    tempres = struct([]);
    
    tempres35 = mean_dice_intramod(1).dice;
    tempres15 = mean_dice_intramod(2).dice;
    
    for t = 1:1:length(grid)
    combi = grid(t,:);
    
    tempresmat35(combi(1), combi(2)) = tempres35(t);
    tempresmat35(combi(2), combi(1)) = tempres35(t);
    
    tempresmat15(combi(1), combi(2)) = tempres15(t);
    tempresmat15(combi(2), combi(1)) = tempres15(t);
    
    end
    
    n=nr_specialists;
    L = specialists;
    figure()
    
    subplot(1,2,1)
    imagesc(tempresmat35)
    set(gca, 'XTick', 1:n); % center x-axis ticks on bins
    set(gca, 'YTick', 1:n); % center y-axis ticks on bins
    set(gca, 'XTickLabel', L); % set x-axis labels
    set(gca, 'YTickLabel', L); % set y-axis labels
    colormap('default'); % set the colorscheme
    cb = colorbar;
    title('0.35T')
    
    subplot(1,2,2)
    imagesc(tempresmat15)
    set(gca, 'XTick', 1:n); % center x-axis ticks on bins
    set(gca, 'YTick', 1:n); % center y-axis ticks on bins
    set(gca, 'XTickLabel', L); % set x-axis labels
    set(gca, 'YTickLabel', L); % set y-axis labels
    colormap('default'); % set the colorscheme
    cb = colorbar;
    title('1.5T')
    
    sgtitle(strcat('Intra modality hausdorff max meaned for all patients'));

    
end