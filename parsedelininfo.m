function Specialist_CTV = parsedelininfo(pat_pathname, specialists)

    for j = 1:1:length(specialists)
        specialist_pathname = strcat(pat_pathname,'\',specialists(j));
        temp_struct = dir(strcat(specialist_pathname,'\RTSTRUCT*.dcm'));
        filename = temp_struct.name;
        RTstruct = dicominfo(strcat(temp_struct.folder,'\',filename));
        Specialist_struct(j) = RTstruct;
        Specialist_CTV(j).contour = Specialist_struct(j).ROIContourSequence.Item_2.ContourSequence;
        amntofcontours = length(fieldnames(Specialist_CTV(j).contour));
        temp = {};
        for k = 1:1:amntofcontours
            if length(Specialist_CTV)>1
            temp{k,1} = eval(strcat('Specialist_CTV(', num2str(j), ').contour.Item_', num2str(k), '.ContourImageSequence.Item_1.ReferencedSOPInstanceUID'));
            else
            temp{k,1} = eval(strcat('Specialist_CTV.contour.Item_', num2str(k), '.ContourImageSequence.Item_1.ReferencedSOPInstanceUID'));
            end
        end
        Specialist_CTV(j).imagenrs = temp;

        
        Slice_list = RTstruct.ReferencedFrameOfReferenceSequence.Item_1.RTReferencedStudySequence.Item_1.RTReferencedSeriesSequence.Item_1.ContourImageSequence;  
        amntofslices = length(fieldnames(Slice_list));
        for t = 1:1:amntofslices
            Slices{t,1} = eval(strcat('Slice_list.Item_',num2str(t),'.ReferencedSOPInstanceUID'));
        end

        Specialist_CTV(j).Refslicenrs = Slices;

        slice = dicomread(dicominfo(strcat(temp_struct.folder,'\','MR', Slices{1,1}, '.dcm')));
        Specialist_CTV(j).Imagesize = size(slice);

    end

end