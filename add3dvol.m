function Proc_Pat_delin = add3dvol(Proc_Pat_delin, nr_patients,nr_mod,nr_specialists)
    for i = 1:1:nr_patients
        for j = 1:1:nr_mod
            TDmask = [];
            for k = 1:1:nr_specialists
                
                firstslice = Proc_Pat_delin(i).mod(j).specialist(k).imagenrs{1,1}; 
                refslices = Proc_Pat_delin(i).mod(j).specialist(k).Refslicenrs;
                imagesize = Proc_Pat_delin(i).mod(j).specialist(k).Imagesize;

                for x = 1:1:length(refslices)
                tf = strcmp(firstslice{:},refslices(x));
                if tf == 1
                    index = x;
                else end
                end
               
                temp_masks = Proc_Pat_delin(i).mod(j).specialist(k).masks;  
                TDmask = cat(3, temp_masks(:).mask);
                TDmask = cat(3, zeros(imagesize(1),imagesize(2),index), TDmask, zeros(imagesize(1),imagesize(2),(length(refslices)-length(temp_masks)-index)));
                %volumeViewer(TDmask);
                Proc_Pat_delin(i).mod(j).specialist(k).TDmask = TDmask;
            end
        end
    end
end