function plotrescomb(plotresults_comb,Result_dice_combined_single,Result_dice_combined_mismatch,Result_hdistD95_combined,Result_hdistmax_combined,mod)
    if plotresults_comb == true
        tempdicecombined = [transpose(Result_dice_combined_single.mod035True),transpose(Result_dice_combined_single.mod15T2)];
        figure()
        boxplot((tempdicecombined),'Labels',mod)
        title(['Combined dice single'])
        xlabel('Image modality')
        ylabel('Dice similarity')
    
        tempdicecombinedmism = [transpose(Result_dice_combined_mismatch.mod035True),transpose(Result_dice_combined_mismatch.mod15T2)];
        figure()
        boxplot((tempdicecombinedmism),'Labels',mod)
        title(['Combined dice mismatch'])
        xlabel('Image modality')
        ylabel('Dice similarity')
    
        temphdist95 = [transpose(Result_hdistD95_combined.mod035True),transpose(Result_hdistD95_combined.mod15T2)];
        figure()
        boxplot((temphdist95),'Labels',mod)
        title(['Combined hausdorff 95th percentile'])
        xlabel('Image modality')
        ylabel('Distance (mm)')
    
        temphdistmax = [transpose(Result_hdistmax_combined.mod035True),transpose(Result_hdistmax_combined.mod15T2)];
        figure()
        boxplot((temphdistmax),'Labels',mod)
        title(['Combined hausdorff max'])
        xlabel('Image modality')
        ylabel('Distance (mm)')
    
        clear tempdicecombinedmism tempdicecombined temphdistmax temphdist95
    else
    end

end
