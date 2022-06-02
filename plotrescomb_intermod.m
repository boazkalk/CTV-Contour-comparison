function plotrescomb_intermod(plotresults_comb_intermod, Result_dice_intermod_combined, Result_hdistD95_intermod_combined, Result_hdistDmax_intermod_combined)
    if plotresults_comb_intermod == true
        tempdicecombined = [transpose(Result_dice_intermod_combined.O35Truevs15T2)];
        figure()
        boxplot((tempdicecombined),'Labels',{'0.35Truefivs1.5T2'})
        title(['Combined dice single intermodality'])
        xlabel('Image modality')
        ylabel('Dice similarity')
    
        tempdicecombinedmism = [transpose(Result_hdistD95_intermod_combined.O35Truevs15T2)];
        figure()
        boxplot((tempdicecombinedmism),'Labels',{'0.35Truefivs1.5T2'})
        title(['Combined hausdorff 95th percentile intermodality'])
        xlabel('Image modality')
        ylabel('Distance (mm)')
    
        temphdistmax = [transpose(Result_hdistDmax_intermod_combined.O35Truevs15T2)];
        figure()
        boxplot((temphdistmax),'Labels',{'0.35Truefivs1.5T2'})
        title(['Combined hausdorff max intermodality'])
        xlabel('Image modality')
        ylabel('Distance (mm)')
    
        clear tempdicecombinedmism tempdicecombined temphdistmax temphdist95
    else
    end

end