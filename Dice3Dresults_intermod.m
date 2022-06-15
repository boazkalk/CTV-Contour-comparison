function Result_dice = Dice3Dresults_intermod(Proc_Pat_delin, nr_patients, nr_mod,nr_specialists)
    % Calculate inter modality dice coefficient by comparing their 3D
    % masks with the Dice coefficient

%     Result_dice_intermod
%         -> Patients
%             -> Specialists' dice coefficient between 0.35T and 1.5T

    for i = 1:1:nr_patients
            for j = 1:1:nr_specialists
                       
                    mask1 = Proc_Pat_delin(i).mod(1).specialist(j).TDmask;
                    mask2 = Proc_Pat_delin(i).mod(2).specialist(j).TDmask;
                    similarity = dice(mask1, mask2);

                    Result_dice(i).spec(j).O35Truevs15T2 = similarity;
            
            end
                if i == 1 
                f = waitbar((i)/nr_patients,'Calculating Dice coefficients...');
                else
                close(f)
                f = waitbar((i)/nr_patients,'Calculating Dice coefficients...');
                end
    end
    close(f)
end