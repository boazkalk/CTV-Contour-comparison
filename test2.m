clear all
close all

matrix(:,:,1) = [0 0 0 0; 0 1 1 0; 0 1 1 0; 0 0 0 0];
matrix(:,:,2) = [0 0 0 0; 0 1 1 0; 0 1 1 0; 0 0 0 0];

aspect = [1.5,3];
volume = 0;

for v = 1:1:2
    mask = matrix(:,:,v);
    %imshow(mask)
    area = bwarea(mask);
    area = area*aspect(1)^2;
    volume = volume+area*aspect(2);
end