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
                    %[D95, D] = hausdorff_dist_calc(mask1,mask2,aspect);
                    [D,D95,idx]=bwhdist2(mask1,mask2,aspect);

%                     figure()
%                     blockPlot(mask1, [0 0 0], 'facecolor','r', 'facealpha',1);
%                     hold on
%                     blockPlot(mask2,[0 0 0], 'facecolor','k', 'facealpha',.5);
%                     hold on
%                     [x y z]=ind2sub(size(mask1),idx);
%                     plot3(x, y, z-10, 'go-');

                    D95ar(t) = D95;
                    Dar(t) = D;
                    end
    
                    Result_D95(i).mod(j).D95 = D95ar;
                    Result_Dmax(i).mod(j).Dmax = Dar;
            
            end
    end

end

function [D,D95,idx]=bwhdist2(A,B,aspect)
    [d_AB,d95_AB,idx_AB]=dir_hdist2(A,B,aspect);
    [d_BA,d95_BA,idx_BA]=dir_hdist2(B,A,aspect);
    if(d_AB>d_BA)
        D=d_AB;
        idx=idx_AB;
    else
        D=d_BA;
        idx=fliplr(idx_BA); % First idx is in A
    end
    D95=max(d95_BA,d95_AB);
end
% Max distance from points in A to B
% Also returning linear indices of fathest point pair
function [D,D95,idx]=dir_hdist2(A,B,aspect)
    if any(A(:))
        [DT,idxB]=bwdistsc(B,aspect);
        A=find(A); % Set points in A
        idxB=idxB(A); % Only care about points under A
        DT=DT(A);
        [D,idxA]=max(DT); % Farthest point in A (out of A~=0)
        D95 = prctile(DT,95);
        idxB=idxB(idxA); % Used point in B
        if idxB>0
            idxA=A(idxA); % Used point in A
            idx=[idxA,idxB];
        else
            idx=[0,0];
        end
    else
        D=single(0); % Distance from [] to B is always zero
        idx=[0,0];
    end
end

% function [D95, D] = hausdorff_dist_calc(A,B,aspect)
% 
% [D_AB, D_AB95] = dist_h(A,B,aspect);
% [D_BA, D_BA95] = dist_h(B,A,aspect);
% % max distance fom B to A or A to B
% D = max(D_AB, D_BA);
% D95 = max(D_AB95, D_BA95);
% 
% end
% 
% function [D,D95]=dist_h(A,B,aspect)
%     
%     [DT,idxB]=bwdistsc(B,aspect); % set up distance matrix and matrix containing indexes of closest nonzero entries in B
%     A2=find(A); % Find all indexes of nonzero entries in A
%     idxB2=idxB(A2); % Find indexes of closest nonzero entries in B that overlap with nonzero entries in A
%     DT=DT(A2); % Also find actual distance of these closest nonzero entries in B that overlap with A
%     [D,idxA]=max(DT); % Find the maximum distance 
%     D95 = prctile(DT,95); % Find the 95th percentile distance
% 
%     idxB3=idxB2(idxA); % Used point in B
%     if idxB3>0
%         idxA2=A(idxA); % Used point in A
%         idx=[idxA2,idxB3];
%     else
%         idx=[0,0];
%     end
% 
% end