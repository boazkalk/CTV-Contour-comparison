slice = dicomread(dicominfo(strcat('C:\School\Master\Stage\Matlab\testdata-echt\PAT1\0.35T2\HPN\MR2.16.840.1.114493.1.4.270.3.20220516110131130.dcm')));

slice2 = dicomread(dicominfo(strcat('C:\School\Master\Stage\Matlab\testdata-echt\PAT1\0.35Truefi\HPN\MR1.3.46.670589.11.41225.5.0.7444.2022051211555225606.dcm')));

slice3 = dicomread(dicominfo(strcat('C:\School\Master\Stage\Matlab\testdata-echt\PAT1\1.5T2\HPN\MR1.3.46.670589.11.41225.5.0.7444.2022051211555226607.dcm')));

subplot(1,3,1)
imshow(slice,[]);
subplot(1,3,2)
imshow(slice2,[]);
subplot(1,3,3)
imshow(slice3,[]);