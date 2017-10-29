% import pandas as pd
% import os
% root='/Users/apple/Desktop/reading/bio/2008-03-11_13/'
% dirlist = [ item for item in os.listdir(root) if os.path.isdir(os.path.join(root, item)) ]
% for subdir in dirlist:
%     fullPath = root + subdir + '/' + subdir + '.txt'
%     df = pd.read_csv(fullPath, sep='\t', lineterminator='\n')
%     df = df[(df['id'] == 'sequenceid') | (df['id'] == 'eye')]
%     df.to_csv(path_or_buf = root + subdir + '/' + subdir + '.csv', sep = ',')

mainFolder = '/Users/apple/Desktop/reading/bio/2008-03-11_13';
allSubFolders = genpath(mainFolder);
remain = allSubFolders;
listOfFolderNames = strsplit(remain, ':');
numberOfFolders = length(listOfFolderNames);
value = {};
key = {};
for k = 2 : numberOfFolders
    
   
    thisFolder = listOfFolderNames{k};
    if isempty(thisFolder)
        continue;
    end
    fprintf('Processing folder %s\n', thisFolder);
    
    txtFile = dir(sprintf('%s/*.txt', thisFolder));
    [index, id, eye] = textread([thisFolder, '/', txtFile.name], '%d %s %s');
    Righttemp = {};
    Rightmask = {};
    Lefttemp = {};
    Leftmask = {};
    for i = 1 : length(index);
        clc;
        fprintf('Process... %f', (k/numberOfFolders + i/length(index)/numberOfFolders) * 100);
        disp('%');
        if strcmp(eye{i}, 'Right')
            disp([thisFolder, '/', id{i}, '.tiff']);
            [template, errmask] = createiristemplate([thisFolder, '/', id{i}, '.tiff']);
            if sum(~errmask(:)) > 200
                Righttemp{end + 1} = template;
                Rightmask{end + 1} = errmask;
            end
        else if strcmp(eye{i}, 'Left')
            [template, errmask] = createiristemplate([thisFolder, '/', id{i}, '.tiff']);
            if sum(~errmask(:)) > 200
                Lefttemp{end + 1} = template;
                Leftmask{end + 1} = errmask;
            end
            end
        end
    end
    value{end + 1} = {Righttemp, Rightmask, Lefttemp, Leftmask};
    key{end + 1} = txtFile.name(1:length(txtFile.name) - 4);
end
data = {key, value};
save('2008.mat','data');





