function Specialist_CTV = parsedelininfo(pat_pathname, specialists)
    
    % Loop over all specialists
    for j = 1:1:length(specialists)
        % Generate pathname, find the RTSTRUCT within that folder and read
        % out the RTSTRUCT
        specialist_pathname = strcat(pat_pathname,'\',specialists(j));
        temp_struct = dir(strcat(specialist_pathname,'\RTSTRUCT*.dcm'));
        filename = temp_struct.name;
        RTstruct = dicominfo(strcat(temp_struct.folder,'\',filename));
        Specialist_struct(j) = RTstruct;

        % Go down in RTSTRUCT and find the specialist's contour for that
        % patient and modality
        Specialist_CTV(j).contour = Specialist_struct(j).ROIContourSequence.Item_2.ContourSequence;
        amntofcontours = length(fieldnames(Specialist_CTV(j).contour));
        temp = {};

        % Put the slice numbers of the contoured slices next to the
        % contours in the final struct
        for k = 1:1:amntofcontours
            if length(Specialist_CTV)>1
            temp{k,1} = eval(strcat('Specialist_CTV(', num2str(j), ').contour.Item_', num2str(k), '.ContourImageSequence.Item_1.ReferencedSOPInstanceUID'));
            else
            temp{k,1} = eval(strcat('Specialist_CTV.contour.Item_', num2str(k), '.ContourImageSequence.Item_1.ReferencedSOPInstanceUID'));
            end
        end
        Specialist_CTV(j).imagenrs = temp;

        % Additionally add all slices within the total image and image size
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