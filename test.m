clear all
close all

bw(:,:,1) = [0 0 0;0 0 0;0 0 0];
bw(:,:,2) = [0 0 0;0 1 0;0 0 0];
bw(:,:,3) = [0 0 0;0 0 0;0 0 0];

aspect = [1.5 1.5 3];

D=bwdistsc(bw,aspect);

