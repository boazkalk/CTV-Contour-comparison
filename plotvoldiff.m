function plotvoldiff(Tumorvolumediff,plotresults_vol,plotresults_vol_comb,nr_patients,specialists)
        if plotresults_vol == true

            voldiff = [transpose(Tumorvolumediff)];
            figure()
            boxplot((voldiff),'Labels',specialists)
            title({'Percentage volume difference between modalities per specialist for all patients','Negative=1.5T<0.35T, Positive=1.5T>0.35T'})
            ylabel('Tumor volume difference %')

        else end
        
        if plotresults_vol_comb == true
            tempvoldiff = [];
            for i = 1:1:nr_patients
            tempvoldiff = [tempvoldiff;Tumorvolumediff(:,i)];
            end

            figure()
            boxplot((tempvoldiff))

            title(['Percentage volume difference between modalities all specialists combined'])
            ylabel('Tumor volume difference %')

        else end
end