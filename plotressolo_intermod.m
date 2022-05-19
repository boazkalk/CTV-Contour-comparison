function plotressolo_intermod(plotresults_solo,Result_dice_intermod,Result_hdistD95_intermod,Result_hdistDmax_intermod,nr_patients)
    if plotresults_solo == true
        for i = 1:1:nr_patients
        patient = i;

        tempdicesingle = table2array(struct2table(Result_dice_intermod(patient).spec));
        figure()
        boxplot((tempdicesingle),'Labels',{'0.35T2vs0.35Truefi','0.35T2vs1.5T2','0.35Truefivs1.5T2'})
        title(['Dice single, Patient = ' num2str(patient)])  
        xlabel('Image modality comparison')
        ylabel('Distance (mm)')
        
        temphdist95 = table2array(struct2table(Result_hdistD95_intermod(patient).spec));
        figure()
        boxplot((temphdist95),'Labels',{'0.35T2vs0.35Truefi','0.35T2vs1.5T2','0.35Truefivs1.5T2'})
        title(['Hdorff95, Patient = ' num2str(patient)])
        xlabel('Image modality comparison')
        ylabel('Distance (mm)')
        
        temphdistmax = table2array(struct2table(Result_hdistDmax_intermod(patient).spec));
        figure()
        boxplot((temphdistmax),'Labels',{'0.35T2vs0.35Truefi','0.35T2vs1.5T2','0.35Truefivs1.5T2'})
        title(['Hdorffmax, Patient = ' num2str(patient)])
        xlabel('Image modality comparison')
        ylabel('Distance (mm)')
    
        clear tempdicesingle temphdist95 temphdistmax
        end
    else
    end
end