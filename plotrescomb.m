%%%%%%%%%%%%%%%%%%%%%%%
% Boaz Kalkhoven 2022 %
%%%%%%%%%%%%%%%%%%%%%%%

function plotrescomb(plotresults_comb,Result_dice_combined_single,Result_dice_combined_mismatch,Result_hdistD95_combined,Result_hdistmax_combined,mod)
    if plotresults_comb == true
        tempdicecombined = [transpose(Result_dice_combined_single.mod035True),transpose(Result_dice_combined_single.mod15T2)];
        figure()
        subplot(1,4,1)
        boxplot((tempdicecombined),'Labels',mod)
        title(['Dice similarity coefficient'])
        xlabel('Image modality')
        ylabel('Dice similarity')
    
        tempdicecombinedmism = [transpose(Result_dice_combined_mismatch.mod035True),transpose(Result_dice_combined_mismatch.mod15T2)];
        %figure()
        subplot(1,4,2)
        boxplot((tempdicecombinedmism),'Labels',mod)
        title(['Mismatch dice similarity coefficient'])
        xlabel('Image modality')
        ylabel('Dice similarity')
    
        temphdist95 = [transpose(Result_hdistD95_combined.mod035True),transpose(Result_hdistD95_combined.mod15T2)];
        %figure()
        subplot(1,4,3)
        boxplot((temphdist95),'Labels',mod)
        title(['Hausdorff distance 95th percentile'])
        xlabel('Image modality')
        ylabel('Distance (mm)')
    
        temphdistmax = [transpose(Result_hdistmax_combined.mod035True),transpose(Result_hdistmax_combined.mod15T2)];
        %figure()
        subplot(1,4,4)
        boxplot((temphdistmax),'Labels',mod)
        title(['Hausdorff distance'])
        xlabel('Image modality')
        ylabel('Distance (mm)')

    
        clear tempdicecombinedmism tempdicecombined temphdistmax temphdist95
    else
    end

end
