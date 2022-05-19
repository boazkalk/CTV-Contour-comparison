function Result_dice = Dice3Dresults_intermod(Proc_Pat_delin, nr_patients, nr_mod,nr_specialists)
    % Calculate inter modality dice coefficient by comparing their 3D
    % masks with the Dice coefficient
    for i = 1:1:nr_patients
            for j = 1:1:nr_specialists
    
                    v = 1:nr_mod;
                    grid = nchoosek(v,2);
                    
                    for t = 1:1:length(grid)
                    combi = grid(t,:);
                    mask1 = Proc_Pat_delin(i).mod(combi(1)).specialist(j).TDmask;
                    mask2 = Proc_Pat_delin(i).mod(combi(2)).specialist(j).TDmask;
                    similarity(t) = dice(mask1, mask2);
                    end
    
                    Result_dice(i).spec(j).O35T2vsTrue = similarity(1);
                    Result_dice(i).spec(j).O35T2vs15T2 = similarity(2);
                    Result_dice(i).spec(j).O35Truevs15T2 = similarity(3);
            
            end
    end
end