clear all
close all

aspect = [1.5,1.5,3];

mask1(:,:,1) = [0 0 0 0;0 0 0 0;0 0 0 0; 0 0 0 0];
mask1(:,:,2) = [0 0 0 0;0 1 1 0;0 1 1 0; 0 0 0 0];
mask1(:,:,3) = [0 0 0 0;0 1 1 0;0 1 1 0; 0 0 0 0];
mask1(:,:,4) = [0 0 0 0;0 0 0 0;0 0 0 0; 0 0 0 0];

mask2(:,:,1) = [0 0 0 0;0 0 0 0;0 0 0 0; 0 0 0 0];
mask2(:,:,2) = [0 0 0 0;0 1 1 0;0 1 1 1; 0 0 0 0];
mask2(:,:,3) = [0 0 0 0;0 1 1 0;0 1 1 0; 0 0 0 0];
mask2(:,:,4) = [0 0 0 0;0 0 0 0;0 0 1 0; 0 0 0 0];

[D,D95,idx]=bwhdist2(mask1,mask2,aspect);

figure()
blockPlot(mask1, [0 0 0], 'facecolor','r', 'facealpha',1);
hold on
blockPlot(mask2,[0 0 0], 'facecolor','k', 'facealpha',.5);
hold on
tempmask = zeros(size(mask1));
tempmask(idx(1))=1;
tempmask(idx(2))=1;
blockPlot(tempmask,[0 0 0], 'facecolor','g', 'facealpha',1);

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
