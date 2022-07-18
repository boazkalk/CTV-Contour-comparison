%%%%%%%%%%%%%%%%%%%%%%%
% Boaz Kalkhoven 2022 %
%%%%%%%%%%%%%%%%%%%%%%%

function Pat_delin = getmasks(Pat_delin,nr_patients,nr_mod, nr_specialists)

% For every Patient->Modality->Specialist
for i = 1:1:nr_patients
    for j = 1:1:nr_mod
        for k = 1:1:nr_specialists
            slicenrs = length(Pat_delin(i).mod(j).specialist(k).imagenrs);  
            for l = 1:1:slicenrs
                % Extract contour
                contour = eval(strcat('Pat_delin(',num2str(i),').mod(',num2str(j),').specialist(',num2str(k),').contour.Item_',num2str(l),'.ContourData'));
                % For contour the middle of image is seen as 0,0 so correct
                % for this by adding half of image size
                imagesize = Pat_delin(i).mod(j).specialist(k).Imagesize;
                contour(3:3:end,:) = [];
                contour_corr2 = [];
                %contour_corr2(:,1) = 0.66666667*contour(1:2:end,1)+imagesize(2)/2;
                %contour_corr2(:,2) = 0.66666667*contour(2:2:end,1)+imagesize(1)/2;
                contour_corr2(:,1) = contour(1:2:end,1)+imagesize(2)/2;
                contour_corr2(:,2) = contour(2:2:end,1)+imagesize(1)/2;
                contour_corr2 = [contour_corr2; contour_corr2(1,:)];
                % Calculate mask from contour and put in struct
                mask = poly2mask(contour_corr2(:,1), contour_corr2(:,2),imagesize(1),imagesize(2));
%                 imshow(mask)
%                 set(gcf, 'Position', get(0, 'Screensize'));
                Pat_delin(i).mod(j).specialist(k).masks(l).mask = mask;
                Pat_delin(i).mod(j).specialist(k).contours(l).contour = contour_corr2;
            end
        end
    end
end

end

