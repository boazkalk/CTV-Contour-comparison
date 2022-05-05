function Result_dice = Dice3Dresults(Proc_Pat_delin, nr_patients, nr_mod,nr_specialists)
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
    end
end