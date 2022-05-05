clear all
close all

folderpath = 'C:\School\Master\Stage\Matlab\testdata';
temp_nr_patients = struct2cell(dir(folderpath));
[~,nr_patients] = size(find(contains(temp_nr_patients(1,:),'PAT')));

mod = ["0.35T2" "0.35Truefi" "1.5T2"];
nr_mod = length(mod);
specialists = ["HPN" "PTN" "TBO" "STR"];
%specialists = ["HPN" "PTN"];
nr_specialists = length(specialists);

Pat_delin = parsetotal(folderpath, nr_patients, mod, specialists);
Pat_delin = getmasks(Pat_delin,nr_patients, nr_mod,nr_specialists);
Pat_delin = sortimagenr_masks(Pat_delin, nr_patients, nr_mod,nr_specialists);
Proc_Pat_delin = removedoubles(Pat_delin, nr_patients,nr_mod,nr_specialists);
Proc_Pat_delin = add3dvol(Proc_Pat_delin, nr_patients,nr_mod,nr_specialists);

Result_dice = Dice3Dresults(Proc_Pat_delin, nr_patients, nr_mod,nr_specialists);

%%
for i = 1:1:nr_patients
patient = i;
tempsim = transpose(table2array(struct2table(Result_dice(patient).mod)));
figure()
boxplot((tempsim),'Labels',{'0.35T2','0.35TrueFi','1.5T2'})
title(['Patient = ' num2str(patient)])
end
%%

% 
% %%
% v = 1:nr_specialists;
% grid = nchoosek(v,2);
% for i = 1:1:nr_patients
%     for j = 1:1:nr_mod
%         for k = 1:1:nr_specialists
%             
%             for t = 1:1:length(grid)
%             combi = grid(t,:);
%             mask1 = Proc_Pat_delin(i).mod(j).specialist(k).masks(combi(1)).mask;
%             mask2 = Proc_Pat_delin(i).mod(j).specialist(k).masks(combi(2)).mask;
%             similarity(i) = dice(mask1, mask2);
%             end
% 
%             Dice.Pat(i).Mod(j).result = similarity;
%         end
%     end
% end
% 
% 
% 
% %%
% teststruct = Proc_Pat_delin(1).mod(1).specialist;
% teststruct(3).contour = teststruct(2).contour;
% teststruct(4).contour = teststruct(2).contour;
% teststruct(3).imagenrs = teststruct(2).imagenrs;
% teststruct(4).imagenrs = teststruct(2).imagenrs;
% teststruct(3).masks = teststruct(2).masks;
% teststruct(4).masks = teststruct(2).masks;
% 
% %%
% imagenrs = cat(1,teststruct.imagenrs);
% temp = transpose([imagenrs{:}]);
% imagenrsunique = unique(temp);
% 
% nr_specialists = 4;
% 
% Result_dice = imagenrsunique(:,1);
% 
% for i = 1:1:length(imagenrsunique)
%     slicenr = imagenrsunique{i};
%     v = 1;
%     masks = struct([]);
%     for j = 1:1:nr_specialists
%         temp = teststruct(j).imagenrs;
%         for k = 1:1:length(temp)
%             tf = strcmp(temp{k},slicenr);
%             if tf == 1
%                 masks(v).mask = teststruct(j).masks(k).mask;
%                 v = v+1;
%                 break
%             else
%             end
%         end
%     end
%     
%     v = 1:length(masks);
%     grid = nchoosek(v,2);
%     for t = 1:1:length(grid)
%     combi = grid(t,:);
%     mask1 = masks(combi(1)).mask;
%     mask2 = masks(combi(2)).mask;
%     similarity(i) = dice(mask1, mask2);
%     end
%     
%     
% end

%%
