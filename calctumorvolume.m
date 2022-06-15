function volumeincluded = calctumorvolume(Proc_Pat_delin, nr_patients, nr_mod,nr_specialists)
% volumeincluded
%     -> Patients
%         -> Modalities
%             -> Specialist volumes in mm3
    for i = 1:1:nr_patients
            for j = 1:1:nr_mod
                for k = 1:1:nr_specialists
    
                    [~,mask_amnt] = size(Proc_Pat_delin(i).mod(j).specialist(k).masks);
                    aspect = Proc_Pat_delin(i).mod(j).specialist(k).Image_Aspect_Ratio;
                    volume = 0;
                    
                    for v = 1:1:mask_amnt
                        mask = Proc_Pat_delin(i).mod(j).specialist(k).masks(v).mask;
                        %imshow(mask)
                        area = bwarea(mask);
                        area = area*aspect(1)*aspect(2);
                        volume = volume+area*aspect(3);
                    end
                    Result(i).mod(j).specialist(k).Tumorvolume = volume;
                        
                end
            end
    end
    volumeincluded = Result;

end