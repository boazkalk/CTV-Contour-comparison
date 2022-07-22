%%%%%%%%%%%%%%%%%%%%%%%
% Boaz Kalkhoven 2022 %
%%%%%%%%%%%%%%%%%%%%%%%

function [Result_D95, Result_Dmax] = hausdorff_dist_intermod(Proc_Pat_delin, nr_patients, nr_mod, nr_specialists)

% Result_D95_intermod
%     -> Patients
%         -> Specialists' 95th percentile hausdorff distance between 0.35T and 1.5T
% 
% Result_Dmax_intermod
%     -> Patients
%         -> Specialists' max hausdorff distance between 0.35T and 1.5T

    for i = 1:1:nr_patients
                if i == 1 
                f = waitbar((i)/nr_patients,'Calculating Hausdorff distances intermod...');
                else
                close(f)
                f = waitbar((i)/nr_patients,'Calculating Hausdorff distances intermod...');
                end
            for j = 1:1:nr_specialists

                    mask1 = Proc_Pat_delin(i).mod(1).specialist(j).TDmask;
                    mask2 = Proc_Pat_delin(i).mod(2).specialist(j).TDmask;

                    aspect1 = Proc_Pat_delin(i).mod(1).specialist(j).Image_Aspect_Ratio;  
                    aspect2 = Proc_Pat_delin(i).mod(2).specialist(j).Image_Aspect_Ratio;

                    [D,D95,idx]=bwhdist2(mask1,mask2,aspect1,aspect2);

                    g = figure;
                    blockPlot(mask1, [0 0 0], 'facecolor','r', 'facealpha',1);
                    hold on
                    blockPlot(mask2,[0 0 0], 'facecolor','k', 'facealpha',.5);
                    hold on
                    tempmask = zeros(size(mask1));
                    tempmask(idx(1))=1;
                    tempmask(idx(2))=1;
                    blockPlot(tempmask,[0 0 0], 'facecolor','g', 'facealpha',1);
                    title(strcat('Patient=', num2str(i), ', Specialist=',num2str(j)));
                    close(g)
    
                    Result_D95(i).spec(j).O35Truevs15T2 = D95;
                    Result_Dmax(i).spec(j).O35Truevs15T2 = D;
                
                    %disp('spec')
            end
             % disp('pat')
    end
close(f)
end

function [D,D95,idx]=bwhdist2(A,B,aspect1,aspect2)
    [d_AB,d95_AB,idx_AB]=dir_hdist2(A,B,aspect2);
    [d_BA,d95_BA,idx_BA]=dir_hdist2(B,A,aspect1);
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
        %plothist(DT)
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
