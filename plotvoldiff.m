function plotvoldiff(Tumorvolumediff,plotresults_vol,plotresults_vol_comb,nr_patients)
        if plotresults_vol == true
            for i = 1:1:nr_patients
            tempvoldiff = [];
            patient = i;
            tempvoldiff = table2array(struct2table(Tumorvolumediff(i).spec));
            figure()
            boxplot((tempvoldiff))

            title(['Volume difference between modalities, Patient = ' num2str(patient)])
            ylabel('Tumor volume difference mm3')
            end
        else end
        
        if plotresults_vol_comb == true
            tempvoldiff = [];
            for i = 1:1:nr_patients
            tempvoldiff = [tempvoldiff;table2array(struct2table(Tumorvolumediff(i).spec))];
            end

            figure()
            boxplot((tempvoldiff))

            title(['Volume difference combined'])
            ylabel('Tumor volume difference mm3')

        else end
end