function Pat_delin = parsetotal(folderpath, nr_patients,mod,specialists)

% For every Patient->Modality->Specialist put contours, slice numbers and
% image information in struct
    for i=1:1:nr_patients
        % Go down from data folder to Patient folder
        pat_pathname = strcat(folderpath, '\Pat', num2str(i));
        disp(i)
        
        for k = 1:1:length(mod)
            % Go down from Patient folder to modality folder
            mod_pathname = strcat(pat_pathname, '\', mod(k));
            disp(mod(k))
            
            % Parse information from RTSTRUCT
            Specialist_CTV = parsedelininfo(mod_pathname, specialists,mod(k));

            % Put information at right place within struct
            Delin(k).specialist = Specialist_CTV;
        end
        
        % Put information at right place within struct
        Pat_delin(i).mod = Delin;
    end
end