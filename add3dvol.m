function Proc_Pat_delin = add3dvol(Proc_Pat_delin, nr_patients,nr_mod,nr_specialists)
    % For all Patients->Modalities->Specialists the 2D masks are combined
    % into 1 3D mask.
    % These 3D masks are put in a matrix that has the same size as the 3D
    % mri image to ensure generality.
    for i = 1:1:nr_patients
        for j = 1:1:nr_mod
            TDmask = [];
            for k = 1:1:nr_specialists
                
                firstslice = Proc_Pat_delin(i).mod(j).specialist(k).imagenrs{1,1}; 
                refslices = Proc_Pat_delin(i).mod(j).specialist(k).Refslicenrs;
                imagesize = Proc_Pat_delin(i).mod(j).specialist(k).Imagesize;
                
                % Find slice where mask begins
                for x = 1:1:length(refslices)
                tf = strcmp(firstslice{:},refslices(x));
                if tf == 1
                    index = x;
                else end
                end
               
                % Put 3D mask in 3D matrix 
                temp_masks = Proc_Pat_delin(i).mod(j).specialist(k).masks;  
                TDmask = cat(3, temp_masks(:).mask);
                TDmask = cat(3, zeros(imagesize(1),imagesize(2),index-1), TDmask, zeros(imagesize(1),imagesize(2),(length(refslices)-length(temp_masks)-index-1)));
                %volumeViewer(TDmask);
                Proc_Pat_delin(i).mod(j).specialist(k).TDmask = TDmask;
            end
        end
    end
end