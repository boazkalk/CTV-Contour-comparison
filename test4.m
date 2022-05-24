mask = Proc_Pat_delin.mod(1).specialist(1).TDmask;

folderpath = 'C:\School\Master\Stage\Matlab\testdata-echt\PAT1\0.35T2\HPN';
temp_nr_patients = struct2cell(dir(folderpath));
j=1;
for i=3:1:146
    slice = dicomread(dicominfo(strcat(folderpath,'\',temp_nr_patients{1,i})));
    image(:,:,j) = slice;
    j=j+1;
end

volumeViewer(image, mask);


