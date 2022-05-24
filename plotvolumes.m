function plotvolumes(Tumorvolumes,plotresults_vol,plotresults_vol_comb,nr_patients)
        if plotresults_vol == true
            for i = 1:1:nr_patients
            tempdicesingle = [];
            patient = i;
            tempdicesingle(:,1) = table2array(struct2table(Tumorvolumes(i).mod(1).specialist));
            tempdicesingle(:,2) = table2array(struct2table(Tumorvolumes(i).mod(2).specialist));
            tempdicesingle(:,3) = table2array(struct2table(Tumorvolumes(i).mod(3).specialist));            
            figure()
            boxplot((tempdicesingle),'Labels',{'0.35T2','0.35TrueFi','1.5T2'})
%             h = findobj(gca,'Tag','Box');
%             colors = [0.3010, 0.7450, 0.9330];
%             for j=1:length(h)
%                 patch(get(h(j),'XData'),get(h(j),'YData'),colors,'FaceAlpha',.35);
%             end
            title(['Volume, Patient = ' num2str(patient)])
            xlabel('Image modality')
            ylabel('Tumor volume mm3')
            end
        else end
        if plotresults_vol_comb == true
            temp1=[];temp2=[];temp3 = [];
            for i = 1:1:nr_patients
            patient = i;
            temp1 = [temp1; table2array(struct2table(Tumorvolumes(i).mod(1).specialist))];
            temp2 = [temp2; table2array(struct2table(Tumorvolumes(i).mod(2).specialist))];
            temp3 = [temp3; table2array(struct2table(Tumorvolumes(i).mod(3).specialist))];
            end
            Vol_comb = [temp1, temp2, temp3];
            figure()
            boxplot((Vol_comb),'Labels',{'0.35T2','0.35TrueFi','1.5T2'})
            title('Volume combined')
            xlabel('Image modality')
            ylabel('Tumor volume mm3')
        else end
end