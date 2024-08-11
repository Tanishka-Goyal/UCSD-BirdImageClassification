function choice = getUserChoice()
% get the option between using Subset or the entire dataset for further
% learning. 

choice = questdlg("Choose an option:", ...
    "Option Selection", ...
    "Entire Dataset", "Subset Dataset", "Entire Dataset");

end