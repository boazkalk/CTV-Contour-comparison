function Tumorvolumediff = calcvoldiff(Tumorvolumes,nr_patients,nr_specialists)

    for i = 1:1:nr_patients
        for k = 1:1:nr_specialists
            voldiff1 = Tumorvolumes(i).mod(1).specialist(k).Tumorvolume;
            voldiff2 = Tumorvolumes(i).mod(2).specialist(k).Tumorvolume;
            diff = abs(voldiff1-voldiff2);

            Tumorvolumediff(i).spec(k).voldiff = diff;
        end
    end

end