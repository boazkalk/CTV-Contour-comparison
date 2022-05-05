function Pat_delin = parsetotal(folderpath, nr_patients,mod,specialists)
    for i=1:1:nr_patients
        pat_pathname = strcat(folderpath, '\Pat', num2str(i));
        
        for k = 1:1:length(mod)
            mod_pathname = strcat(pat_pathname, '\', mod(k));
            
            Specialist_CTV = parsedelininfo(mod_pathname, specialists);
    
            Delin(k).specialist = Specialist_CTV;
        end
    
        Pat_delin(i).mod = Delin;
    end
end