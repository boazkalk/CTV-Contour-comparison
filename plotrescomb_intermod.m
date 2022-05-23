function plotrescomb_intermod(plotresults_comb_intermod, Result_dice_intermod_combined, Result_hdistD95_intermod_combined, Result_hdistDmax_intermod_combined)
    if plotresults_comb_intermod == true
        tempdicecombined = [transpose(Result_dice_intermod_combined.O35T2vsTrue),transpose(Result_dice_intermod_combined.O35T2vs15T2),transpose(Result_dice_intermod_combined.O35Truevs15T2)];
        figure()
        boxplot((tempdicecombined),'Labels',{'O35T2vsTrue','O35T2vs15T2','O35Truevs15T2'})
        title(['Combined dice single intermodality'])
        xlabel('Image modality')
        ylabel('Dice similarity')
    
        tempdicecombinedmism = [transpose(Result_hdistD95_intermod_combined.O35T2vsTrue),transpose(Result_hdistD95_intermod_combined.O35T2vs15T2),transpose(Result_hdistD95_intermod_combined.O35Truevs15T2)];
        figure()
        boxplot((tempdicecombinedmism),'Labels',{'O35T2vsTrue','O35T2vs15T2','O35Truevs15T2'})
        title(['Combined hausdorff 95th percentile intermodality'])
        xlabel('Image modality')
        ylabel('Distance (mm)')
    
        temphdistmax = [transpose(Result_hdistDmax_intermod_combined.O35T2vsTrue),transpose(Result_hdistDmax_intermod_combined.O35T2vs15T2),transpose(Result_hdistDmax_intermod_combined.O35Truevs15T2)];
        figure()
        boxplot((temphdistmax),'Labels',{'O35T2vsTrue','O35T2vs15T2','O35Truevs15T2'})
        title(['Combined hausdorff max intermodality'])
        xlabel('Image modality')
        ylabel('Distance (mm)')
    
        clear tempdicecombinedmism tempdicecombined temphdistmax temphdist95
    else
    end

end