function plotrescomb(plotresults_comb,Result_dice_combined_single,Result_dice_combined_mismatch,Result_hdistD95_combined,Result_hdistmax_combined)
    if plotresults_comb == true
        tempdicecombined = [transpose(Result_dice_combined_single.mod035T2),transpose(Result_dice_combined_single.mod035True),transpose(Result_dice_combined_single.mod15T2)];
        figure()
        boxplot((tempdicecombined),'Labels',{'0.35T2','0.35TrueFi','1.5T2'})
        title(['Combined dice single'])
        xlabel('Image modality')
        ylabel('Dice similarity')
    
        tempdicecombinedmism = [transpose(Result_dice_combined_mismatch.mod035T2),transpose(Result_dice_combined_mismatch.mod035True),transpose(Result_dice_combined_mismatch.mod15T2)];
        figure()
        boxplot((tempdicecombinedmism),'Labels',{'0.35T2','0.35TrueFi','1.5T2'})
        title(['Combined dice mismatch'])
        xlabel('Image modality')
        ylabel('Dice similarity')
    
        temphdist95 = [transpose(Result_hdistD95_combined.mod035T2),transpose(Result_hdistD95_combined.mod035True),transpose(Result_hdistD95_combined.mod15T2)];
        figure()
        boxplot((temphdist95),'Labels',{'0.35T2','0.35TrueFi','1.5T2'})
        title(['Combined hausdorff 95th percentile'])
        xlabel('Image modality')
        ylabel('Distance (mm)')
    
        temphdistmax = [transpose(Result_hdistmax_combined.mod035T2),transpose(Result_hdistmax_combined.mod035True),transpose(Result_hdistmax_combined.mod15T2)];
        figure()
        boxplot((temphdistmax),'Labels',{'0.35T2','0.35TrueFi','1.5T2'})
        title(['Combined hausdorff max'])
        xlabel('Image modality')
        ylabel('Distance (mm)')
    
        clear tempdicecombinedmism tempdicecombined temphdistmax temphdist95
    else
    end

end
