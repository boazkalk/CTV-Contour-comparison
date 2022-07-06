function plotrescomb_intermod(plotresults_comb_intermod, Result_intermod_combined_perspec, Result_intermod_combined_total, specialists)
    if plotresults_comb_intermod == true

        tempdicecombined = [transpose(Result_intermod_combined_total.dice)];
        figure()
        boxplot((tempdicecombined),'Labels',{'0.35Truefivs1.5T2'})
        title(['Combined dice single intermodality'])
        xlabel('Image modality')
        ylabel('Dice similarity')

        temphdist95 = [transpose(Result_intermod_combined_total.hdorff95)];
        figure()
        boxplot((temphdist95),'Labels',{'0.35Truefivs1.5T2'})
        title(['Combined hausdorff 95th percentile intermodality'])
        xlabel('Image modality')
        ylabel('Distance (mm)')
    
        temphdistmax = [transpose(Result_intermod_combined_total.hdorffmax)];
        figure()
        boxplot((temphdistmax),'Labels',{'0.35Truefivs1.5T2'})
        title(['Combined max hausdorff intermodality'])
        xlabel('Image modality')
        ylabel('Distance (mm)')


        tempdicecombined_spec = [transpose(Result_intermod_combined_perspec.dice)];
        figure()
        boxplot((tempdicecombined_spec),'Labels',specialists)
        title(['Combined dice similarity per specialist'])
        xlabel('Image modality')
        ylabel('Dice similarity')
    
        temphdorff95combined_spec = [transpose(Result_intermod_combined_perspec.hdorff95)];
        figure()
        boxplot((temphdorff95combined_spec),'Labels',specialists)
        title(['Combined 95th perc Hausdorff distance per specialist'])
        xlabel('Image modality')
        ylabel('Dice similarity')

        temphdorffmaxcombined_spec = [transpose(Result_intermod_combined_perspec.hdorffmax)];
        figure()
        boxplot((temphdorffmaxcombined_spec),'Labels',specialists)
        title(['Combined max Hausdorff distance per specialist'])
        xlabel('Image modality')
        ylabel('Dice similarity')

    else
    end

end