%%%%%%%%%%%%%%%%%%%%%%%
% Boaz Kalkhoven 2022 %
%%%%%%%%%%%%%%%%%%%%%%%

function Result_dice_mismatch = dice_mismatch(Proc_Pat_delin, nr_patients, nr_mod, nr_specialists)
%   Dice similarity between the Union and Intersection of the 4 specialists'
%   tumor delineations
% 
%     Result_dice_mismatch
%         -> Patients
%             -> Per modality dice of union and intersection of observers

    for i = 1:1:nr_patients
        for j = 1:1:nr_mod
            mask_intersect = Proc_Pat_delin(i).mod(j).specialist(1).TDmask;
            mask_union = Proc_Pat_delin(i).mod(j).specialist(1).TDmask;

            for k = 2:1:nr_specialists
                mask2 = Proc_Pat_delin(i).mod(j).specialist(k).TDmask;
    
                temp_mask_union = mask_union+mask2;
                mask_union = double(logical(temp_mask_union));
                
                temp_mask_inter = mask_intersect+mask2;
                temp_mask_inter(temp_mask_inter<2) = 0;
                mask_intersect = double(logical(temp_mask_inter));
    
%                 g = figure;
%                 blockPlot(mask_intersect, [0 0 0], 'facecolor','r', 'facealpha',1);
%                 hold on
%                 blockPlot(mask_union,[0 0 0], 'facecolor','k', 'facealpha',.5);
%                 title(strcat('Patient=', num2str(i), ', Mod=',num2str(j)));
%                 close(g)

            end
            Dice_mismatch = dice(mask_intersect, mask_union);
            Result_dice_mismatch(i).mod(j).dice = Dice_mismatch;
        end
        if i == 1 
        f = waitbar((i)/nr_patients,'Calculating Dice mismatch...');
        else
        close(f)
        f = waitbar((i)/nr_patients,'Calculating Dice mismatch...');
        end
    end
    close(f)
end