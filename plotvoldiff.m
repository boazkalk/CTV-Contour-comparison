function plotvoldiff(Tumorvolumediff,plotresults_vol,plotresults_vol_comb,nr_patients,specialists)
        figure()
        if plotresults_vol == true

            voldiff = [transpose(Tumorvolumediff)];
            subplot(1,3,[1 2])
            boxplot((voldiff),'Labels',specialists)
            title({'Percentage volume difference per specialist'})
            ylabel('Tumor volume difference %')
            xlabel('Specialists');

        else end
        
        if plotresults_vol_comb == true
            tempvoldiff = [];
            for i = 1:1:nr_patients
            tempvoldiff = [tempvoldiff;Tumorvolumediff(:,i)];
            end

            %figure()
            subplot(1,3,3)
            boxplot((tempvoldiff))

            title({'All specialists combined'});
            
            %ylabel('Tumor volume difference %')

        else end
end