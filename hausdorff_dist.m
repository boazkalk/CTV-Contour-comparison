function [Result_D95, Result_Dmax] = hausdorff_dist(Proc_Pat_delin, nr_patients, nr_mod, nr_specialists)

    for i = 1:1:nr_patients
            for j = 1:1:nr_mod
                    % set up search grid to compare every 3D mask of every
                    % specialist
                    v = 1:nr_specialists;
                    grid = nchoosek(v,2);

                    aspect = Proc_Pat_delin(i).mod(j).specialist(1).Image_Aspect_Ratio;  
                    
                    for t = 1:1:length(grid)
                    combi = grid(t,:);
                    mask1 = Proc_Pat_delin(i).mod(j).specialist(combi(1)).TDmask;
                    mask2 = Proc_Pat_delin(i).mod(j).specialist(combi(2)).TDmask;
                    [D95, D] = hausdorff_dist_calc(mask1,mask2,aspect);
                    D95ar(t) = D95;
                    Dar(t) = D;
                    end
    
                    Result_D95(i).mod(j).D95 = D95ar;
                    Result_Dmax(i).mod(j).Dmax = Dar;
            
            end
    end

end

function [D95, D] = hausdorff_dist_calc(A,B,aspect)

[D_AB, D_AB95] = dist_h(A,B,aspect);
[D_BA, D_BA95] = dist_h(B,A,aspect);
% max distance fom B to A or A to B
D = max(D_AB, D_BA);
D95 = max(D_AB95, D_BA95);

end

function [D,D95]=dist_h(A,B,aspect)
    
    DT=bwdistsc(B,aspect);
    [~,idxB]=bwdist(B,"euclidean"); % set up distance matrix and matrix containing indexes of closest nonzero entries in B
    A2=find(A); % Find all indexes of nonzero entries in A
    idxB2=idxB(A2); % Find indexes of closest nonzero entries in B that overlap with nonzero entries in A
    DT=DT(A2); % Also find actual distance of these closest nonzero entries in B that overlap with A
    D = max(DT); % Find the maximum distance 
    D95 = prctile(DT,95); % Find the 95th percentile distance

end