function [Result_D95, Result_Dmax] = hausdorff_dist(Proc_Pat_delin, nr_patients, nr_mod, nr_specialists)
% 
% Result_D95
%     -> Patients
%         -> Modalities
%             -> 95th perc Hausdorff distance between contours of observers (search grid)
% 
% Result_Dmax
%     -> Patients
%         -> Modalities
%             -> max Hausdorff distance between contours of observers (search grid)
    
    for i = 1:1:nr_patients
        disp(strcat('pat=', num2str(i)));
                if i == 1 
                f = waitbar((i)/nr_patients,'Calculating Hausdorff distances...');
                else
                close(f)
                f = waitbar((i)/nr_patients,'Calculating Hausdorff distances...');
                end
            for j = 1:1:nr_mod
                disp(strcat('mod=', num2str(j)));
                    % set up search grid to compare every 3D mask of every
                    % specialist
                    v = 1:nr_specialists;
                    grid = nchoosek(v,2);

                    aspect = Proc_Pat_delin(i).mod(j).specialist(1).Image_Aspect_Ratio;  

                    D95ar = [];
                    Dar =[];
                    
                    for t = 1:1:length(grid)
                        disp(strcat('grid=', num2str(t)));
                    combi = grid(t,:);
                    mask1 = Proc_Pat_delin(i).mod(j).specialist(combi(1)).TDmask;
                    mask2 = Proc_Pat_delin(i).mod(j).specialist(combi(2)).TDmask;
                    [D,D95,idx]=bwhdist2(mask1,mask2,aspect);

%                     g = figure;
%                     blockPlot(mask1, [0 0 0], 'facecolor','r', 'facealpha',1);
%                     hold on
%                     blockPlot(mask2,[0 0 0], 'facecolor','k', 'facealpha',.5);
%                     hold on
%                     tempmask = zeros(size(mask1));
%                     tempmask(idx(1))=1;
%                     tempmask(idx(2))=1;
%                     blockPlot(tempmask,[0 0 0], 'facecolor','g', 'facealpha',1);
%                     title(strcat('Patient=', num2str(i), ', Specialist=',num2str(j)));
%                     close(g)
                   
                    D95ar(t) = D95;
                    Dar(t) = D;  

                    %disp('grid');
                    end
    
                    Result_D95(i).mod(j).D95 = D95ar;
                    Result_Dmax(i).mod(j).Dmax = Dar;
                      
                    %disp('mod');
            end   
                
    end
    close(f)

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
