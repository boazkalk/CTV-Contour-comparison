function Result_dice_mismatch = dice_mismatch(Proc_Pat_delin, nr_patients, nr_mod, nr_specialists)
%Dice similarity between the Union and Intersection of the 4 specialists'
%tumor delineations

    for i = 1:1:nr_patients
        for j = 1:1:nr_mod
            mask_intersect = Proc_Pat_delin(i).mod(j).specialist(1).TDmask;
            mask_union = Proc_Pat_delin(i).mod(j).specialist(1).TDmask;
            %volumeViewer(mask_union);
            for k = 2:1:nr_specialists
                mask2 = Proc_Pat_delin(i).mod(j).specialist(k).TDmask;
                %volumeViewer(mask2);
    
                temp_mask_union = mask_union+mask2;
                mask_union = double(logical(temp_mask_union));
                
                temp_mask_inter = mask_intersect+mask2;
                temp_mask_inter(temp_mask_inter<2) = 0;
                mask_intersect = double(logical(temp_mask_inter));
    
                %volumeViewer(mask_intersect);
                %volumeViewer(mask_union);
                totalsteps = nr_patients*nr_mod*nr_specialists;
                    if i == 1 && j == 1 && k == 2
                    f = waitbar((i*j*k)/totalsteps,'Calculating dice mismatch...');
                    else
                    close(f)
                    f = waitbar((i*j*k)/totalsteps,'Calculating dice mismatch...');
                    end


            end
            Dice_mismatch = dice(mask_intersect, mask_union);
            Result_dice_mismatch(i).mod(j).dice = Dice_mismatch;
        end
    end
    close(f)
end