function [ subfolders ] = findSubFolders( baseDir, srcExp )
%{
    Author: Ricardo de Lima Thomaz
    Date: 05/07/2017
    Description: Find all subfolders containing at least one item of srcExp
    (search expression).
    Example: findSubFolders(pwd,'^(A)\w*.dcm')
        Comments: find all subfolders containing files begining with an A
        and ending with .dcm. The \w* means that the file might have
        anything between A and .dcm.

    subfolders  -> list of folders containing the search expression
    baseDir     -> the base directory for search subfolders
    srcExp      -> search expression of type 'regular expression'

    Contact: rlthomaz@outlook.com
%}

directory = dir(baseDir);
subfolders = {};
for i = 1:length(directory)
    if ~directory(i).isdir && ~strcmp(directory(i).name,'.') &&...
            ~strcmp(directory(i).name,'..') &&...
            ~isempty(regexp(directory(i).name,srcExp,'match'))
        temp =  regexp(baseDir,'\\','split');
        subfolders{length(subfolders)+1,1} = temp{end};
        if i < length(directory) && ~directory(i+1).isdir
            return;
        end
    elseif directory(i).isdir && ~strcmp(directory(i).name,'.') &&...
            ~strcmp(directory(i).name,'..') 
        pname = fullfile(baseDir,directory(i).name);
        OutSubTemp=findSubFolders(pname, srcExp);
        if ~isempty(OutSubTemp)
            subfolders((length(subfolders)+1):(length(subfolders)+...
                length(OutSubTemp)),1) = OutSubTemp;
        end
    end
end

end

