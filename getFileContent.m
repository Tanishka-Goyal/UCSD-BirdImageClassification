function content = getFileContent(fileName,ind)

fid = fopen(fileName, 'r');
if ind == 1
    fileNames = textscan(fid, '%d %d');
    fclose(fid);
else
    fileNames = textscan(fid, '%d %s', 'Delimiter','\n');
    fclose(fid);
end

content = fileNames{2};
end