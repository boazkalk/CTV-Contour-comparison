function Result_dice = Dice3Dresults(Proc_Pat_delin, nr_patients, nr_mod,nr_specialists)
    % Calculate inter specialist dice coefficient by comparing their 3D
    % masks with the Dice coefficient
    for i = 1:1:nr_patients
            for j = 1:1:nr_mod
    
                    v = 1:nr_specialists;
                    grid = nchoosek(v,2);
                    
                    for t = 1:1:length(grid)
                    combi = grid(t,:);
                    mask1 = Proc_Pat_delin(i).mod(j).specialist(combi(1)).TDmask;
                    mask2 = Proc_Pat_delin(i).mod(j).specialist(combi(2)).TDmask;
                    similarity(t) = dice(mask1, mask2);
                        
                    end
    
                    Result_dice(i).mod(j).dice = similarity;
            
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