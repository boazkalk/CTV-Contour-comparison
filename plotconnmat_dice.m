function plotconnmat_dice(specialists, nr_patients, nr_specialists, Result_dice_single_intramod)

    figure()
    for j = 1:1:nr_patients
    
    patient = j;
    
    v = 1:nr_specialists;
    grid = nchoosek(v,2);
    
    tempresmat35 = eye(nr_specialists,nr_specialists);
    tempresmat15 = eye(nr_specialists,nr_specialists);
    tempres = struct([]);
    
    tempres35 = Result_dice_single_intramod(patient).mod(1).dice;
    tempres15 = Result_dice_single_intramod(patient).mod(2).dice;
    
    for t = 1:1:length(grid)
    combi = grid(t,:);
    
    tempresmat35(combi(1), combi(2)) = tempres35(t);
    tempresmat35(combi(2), combi(1)) = tempres35(t);
    
    tempresmat15(combi(1), combi(2)) = tempres15(t);
    tempresmat15(combi(2), combi(1)) = tempres15(t);
    
    end
    
    n=nr_specialists;
    L = specialists;
    

    subplot(2,nr_patients,j)
    imagesc(tempresmat35)
    set(gca, 'XTick', 1:n); % center x-axis ticks on bins
    set(gca, 'YTick', 1:n); % center y-axis ticks on bins
    set(gca, 'XTickLabel', L); % set x-axis labels
    set(gca, 'YTickLabel', L); % set y-axis labels
    colormap('default'); % set the colorschemeimagenrs
    cb = colorbar;
    title(strcat('0.35T, patient=', num2str(j)'));
    
    subplot(2,nr_patients,nr_patients+j)
    imagesc(tempresmat15)
    set(gca, 'XTick', 1:n); % center x-axis ticks on bins
    set(gca, 'YTick', 1:n); % center y-axis ticks on bins
    set(gca, 'XTickLabel', L); % set x-axis labels
    set(gca, 'YTickLabel', L); % set y-axis labels
    colormap('default'); % set the colorscheme
    cb = colorbar;
    title(strcat('1.5T, patient=', num2str(j)'))
    
    
    
    end

    sgtitle(strcat('Intra modality dice coefficient'));
    
%     mean_dice_intramod = struct([]);
%     mean_dice_intramod(1).dice = zeros(1,length(grid));
%     mean_dice_intramod(2).dice = zeros(1,length(grid));
%     for j = 1:1:nr_patients
%         mean_dice_intramod(1).dice = mean_dice_intramod(1).dice + Result_dice_single_intramod(j).mod(1).dice;
%         mean_dice_intramod(2).dice = mean_dice_intramod(2).dice + Result_dice_single_intramod(j).mod(2).dice;
%     end
%     mean_dice_intramod(1).dice = mean_dice_intramod(1).dice/nr_patients;
%     mean_dice_intramod(2).dice = mean_dice_intramod(2).dice/nr_patients;
% 
%     v = 1:nr_specialists;
%     grid = nchoosek(v,2);
%     
%     tempresmat35 = eye(nr_specialists,nr_specialists);
%     tempresmat15 = eye(nr_specialists,nr_specialists);
%     tempres = struct([]);
%     
%     tempres35 = mean_dice_intramod(1).dice;
%     tempres15 = mean_dice_intramod(2).dice;
%     
%     for t = 1:1:length(grid)
%     combi = grid(t,:);
%     
%     tempresmat35(combi(1), combi(2)) = tempres35(t);
%     tempresmat35(combi(2), combi(1)) = tempres35(t);
%     
%     tempresmat15(combi(1), combi(2)) = tempres15(t);
%     tempresmat15(combi(2), combi(1)) = tempres15(t);
%     
%     end
%     
%     n=nr_specialists;
%     L = specialists;
%     figure()
%     
%     subplot(1,2,1)
%     imagesc(tempresmat35)
%     set(gca, 'XTick', 1:n); % center x-axis ticks on bins
%     set(gca, 'YTick', 1:n); % center y-axis ticks on bins
%     set(gca, 'XTickLabel', L); % set x-axis labels
%     set(gca, 'YTickLabel', L); % set y-axis labels
%     colormap('default'); % set the colorscheme
%     cb = colorbar;
%     title('0.35T')
%     
%     subplot(1,2,2)
%     imagesc(tempresmat15)
%     set(gca, 'XTick', 1:n); % center x-axis ticks on bins
%     set(gca, 'YTick', 1:n); % center y-axis ticks on bins
%     set(gca, 'XTickLabel', L); % set x-axis labels
%     set(gca, 'YTickLabel', L); % set y-axis labels
%     colormap('default'); % set the colorscheme
%     cb = colorbar;
%     title('1.5T')
%     
%     sgtitle(strcat('Intra modality dice coefficient meaned for all patients'));
% 
%     
end