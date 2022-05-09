function Pat_delin = sortimagenr_masks(Pat_delin, nr_patients, nr_mod, nr_specialists)

% Sort the masks according to slice number
for i = 1:1:nr_patients
    for j = 1:1:nr_mod
        for k = 1:1:nr_specialists
            imagenrsadapt = [];
            slicenrs = length(Pat_delin(i).mod(j).specialist(k).imagenrs); 
            for l = 1:1:slicenrs
                slicenr = Pat_delin(i).mod(j).specialist(k).imagenrs{l};
                tempnr = strrep(slicenr,'.','');
                imagenrsadapt(l) = str2num(tempnr(end-5:end));
            end
            [B,I] = sort(imagenrsadapt);
            Pat_delin(i).mod(j).specialist(k).imagenrs = Pat_delin(i).mod(j).specialist(k).imagenrs(I); 
            Pat_delin(i).mod(j).specialist(k).masks = Pat_delin(i).mod(j).specialist(k).masks(I);
        end
    end
end

end