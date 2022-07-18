%%%%%%%%%%%%%%%%%%%%%%%
% Boaz Kalkhoven 2022 %
%%%%%%%%%%%%%%%%%%%%%%%

function plotvolumes(Tumorvolumes,plotresults_vol,plotresults_vol_comb,nr_patients,mod)
        if plotresults_vol == true
            for i = 1:1:nr_patients
            tempdicesingle = [];
            patient = i;
            for k = 1:1:length(mod)
            tempdicesingle(:,k) = table2array(struct2table(Tumorvolumes(i).mod(k).specialist));   
            end
            figure()
            boxplot((tempdicesingle),'Labels',mod)
%             h = findobj(gca,'Tag','Box');
%             colors = [0.3010, 0.7450, 0.9330];
%             for j=1:length(h)
%                 patch(get(h(j),'XData'),get(h(j),'YData'),colors,'FaceAlpha',.35);
%             end
            title(['Volumes of all specialists per modality, Patient = ' num2str(patient)])
            xlabel('Image modality')
            ylabel('Tumor volume mm3')
            end
        else end
%         if plotresults_vol_comb == true
% 
%             for k = 1:1:length(mod)
%                 temp = [];
%                 for i = 1:1:nr_patients
%                     temp = [temp; table2array(struct2table(Tumorvolumes(i).mod(k).specialist))];
%                 end
%                 Vol_comb(:,k) = temp;
%             end            
%             
%             figure()
%             boxplot((Vol_comb),'Labels',mod)
%             title('Volume combined')
%             xlabel('Image modality')
%             ylabel('Tumor volume mm3')
%         else end
end