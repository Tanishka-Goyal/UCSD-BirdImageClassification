function [] = disp16(labels, image_full, image_bb, classes)

num_img = 16; % for a 4 by 4 matrix. 

ind = randperm(length(labels), num_img); % random indices for image and label

fig = figure;
set(fig, 'OuterPosition', [476, 127, 914, 653]);

for i = 1: num_img
    img = image_full(:,:,:,ind(i)); % selecting each image
    lbl = labels(ind(i)); % getting the label for that particular image. 
    head = strrep(classes{lbl}, '_', '\_'); % to get underscore as it is. 


    subplot(4,4,i);
    imshow(img);
    title(head);
end

fig = figure;
set(fig, 'OuterPosition', [476, 127, 914, 653]);

for i = 1: num_img
    img = image_bb(:,:,:,ind(i)); % selecting each image
    lbl = labels(ind(i)); % getting the label for that particular image. 
    head = strrep(classes{lbl}, '_', '\_'); % to get underscore as it is. 


    subplot(4,4,i);
    imshow(img);
    title(head);
end
end