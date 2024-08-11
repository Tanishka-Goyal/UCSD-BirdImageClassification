function [Part1, Part2, Part3, Part4, Part5] = divideData(lbl_all)

unique_labels = unique(lbl_all);
num_labels = length(unique_labels);

% Initialize variables for each part
num_parts = 5;
Part1 = [];
Part2 = [];
Part3 = [];
Part4 = [];
Part5 = [];

% Iterate over each label and distribute its indices into 5 parts
for i = 1:num_labels
    % Get indices of data corresponding to the current label
    label_indices = find(lbl_all == unique_labels(i));
    
    % Calculate the number of indices for 20% of the label
    num_indices_part = ceil(0.2 * length(label_indices));
    
    % Divide the label indices into 5 parts without shuffling
    for j = 1:num_parts
        start_index = (j - 1) * num_indices_part + 1;
        end_index = min(j * num_indices_part, length(label_indices));
        
        % Store indices for the current part
        switch j
            case 1
                Part1 = [Part1; label_indices(start_index:end_index)];
            case 2
                Part2 = [Part2; label_indices(start_index:end_index)];
            case 3
                Part3 = [Part3; label_indices(start_index:end_index)];
            case 4
                Part4 = [Part4; label_indices(start_index:end_index)];
            case 5
                Part5 = [Part5; label_indices(start_index:end_index)];
        end
    end
end

end