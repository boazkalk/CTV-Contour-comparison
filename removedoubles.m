%%%%%%%%%%%%%%%%%%%%%%%
% Boaz Kalkhoven 2022 %
%%%%%%%%%%%%%%%%%%%%%%%

function Proc_Pat_delin = removedoubles(Pat_delin, nr_patients,nr_mod,nr_specialists)
    % If the contour in one slice is disconnected for some reason, two
    % contours are created for the same slice number. Here these two
    % contours are combined in one mask.
    Proc_Pat_delin = Pat_delin;
    for i = 1:1:nr_patients
        for j = 1:1:nr_mod
            for k = 1:1:nr_specialists
                slicenr = length(Pat_delin(i).mod(j).specialist(k).imagenrs);
                slicenrs = Pat_delin(i).mod(j).specialist(k).imagenrs;
    
                masks = Pat_delin(i).mod(j).specialist(k).masks;
    
                z = 1;
                l = 1;
                totalslicenr = {};
                totalmasks = struct([]);
                while l < slicenr
                slicenr1 = slicenrs(l);
                slicenr2 = slicenrs(l+1);
                if isequal(slicenr1, slicenr2)
                    totalslicenr{z,1} = slicenr1;
                    totalmasks(z).mask = (logical(masks(l).mask+masks(l+1).mask));
                    l = l+2;
                    z = z+1;
                    if l == slicenr
                        totalslicenr{z,1} = slicenrs(l);
                        totalmasks(z).mask = (logical(masks(l).mask));
                    end
                else
                    totalslicenr{z,1} = slicenr1;
                    totalmasks(z).mask = (logical(masks(l).mask));
                    if l == slicenr-1
                        totalslicenr{z+1,1} = slicenr2;
                        totalmasks(z+1).mask = (logical(masks(l+1).mask));
                    end
                    l = l+1;
                    z = z+1;
                end
            
                end
                Proc_Pat_delin(i).mod(j).specialist(k).imagenrs = totalslicenr; 
                Proc_Pat_delin(i).mod(j).specialist(k).masks = totalmasks;
                
            end
        end
    end
end