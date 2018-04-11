function strs = readFileToStrs(filename)
% fid = fopen('input.txt','r');
fid = fopen(filename,'r');
strs = [];
tline = fgets(fid);
while ischar(tline)
    strs = [strs tline];
    tline = fgets(fid);    
end
fclose(fid);