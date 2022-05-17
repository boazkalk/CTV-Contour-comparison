function plotressolo(plotresults_solo,Result_dice_single,Result_hdistD95,Result_hdistDmax)
    if plotresults_solo == true
        for i = 1:1:nr_patients
        patient = i;
        tempdicesingle = transpose(table2array(struct2table(Result_dice_single(patient).mod)));
        figure()
        boxplot((tempdicesingle),'Labels',{'0.35T2','0.35TrueFi','1.5T2'})
        title(['Dice, Patient = ' num2str(patient)])
        xlabel('Image modality')
        ylabel('Dice similarity')
        
        temphdist95 = transpose(table2array(struct2table(Result_hdistD95(patient).mod)));
        figure()
        boxplot((temphdist95),'Labels',{'0.35T2','0.35TrueFi','1.5T2'})
        title(['Hdorff95, Patient = ' num2str(patient)])
        xlabel('Image modality')
        ylabel('Distance (mm)')
        
        temphdistmax = transpose(table2array(struct2table(Result_hdistDmax(patient).mod)));
        figure()
        boxplot((temphdistmax),'Labels',{'0.35T2','0.35TrueFi','1.5T2'})
        title(['Hdorffmax, Patient = ' num2str(patient)])
        xlabel('Image modality')
        ylabel('Distance (mm)')
    
        clear tempdicesingle temphdist95 temphdistmax
        end
    else
    end
end