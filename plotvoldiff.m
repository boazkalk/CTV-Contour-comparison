function plotvoldiff(Tumorvolumediff,plotresults_vol,plotresults_vol_comb,nr_patients,specialists)
        if plotresults_vol == true

            voldiff = [transpose(Tumorvolumediff)];
            figure()
            boxplot((voldiff),'Labels',specialists)
            title(['Volume difference between modalities'])
            ylabel('Tumor volume difference mm3')

        else end
        
        if plotresults_vol_comb == true
            tempvoldiff = [];
            for i = 1:1:nr_patients
            tempvoldiff = [tempvoldiff;Tumorvolumediff(:,i)];
            end

            figure()
            boxplot((tempvoldiff))

            title(['Volume difference combined'])
            ylabel('Tumor volume difference mm3')

        else end
end