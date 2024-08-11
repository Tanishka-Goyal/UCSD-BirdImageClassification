%% Deciding the dataset
clear; clc; 
userChoice = getUserChoice();

%% Getting the data
% Defining file paths:
switch userChoice
    case "Entire Dataset"
        image_txt = "./CUB_200_2011/images.txt";
        class_txt = "./CUB_200_2011/classes.txt";
        image_class_label = "./CUB_200_2011/image_class_labels.txt";
        train_txt = "./CUB_200_2011/train200.txt";
        test_txt = "./CUB_200_2011/test200.txt";
        val_txt = "./CUB_200_2011/validate200.txt";
        image_folder = "./CUB_200_2011/images";
        bb_txt = "./CUB_200_2011/bounding_boxes.txt";
        num = 200;
    case "Subset Dataset"
        image_txt = "./CUB_200_2011_Subset20classes/images.txt";
        class_txt = "./CUB_200_2011_Subset20classes/classes.txt";
        image_class_label = "./CUB_200_2011_Subset20classes/image_class_labels.txt";
        train_txt = "./CUB_200_2011_Subset20classes/train.txt";
        test_txt = "./CUB_200_2011_Subset20classes/test.txt";
        val_txt = "./CUB_200_2011_Subset20classes/validate.txt";
        image_folder = "./CUB_200_2011_Subset20classes/images";
        bb_txt = "./CUB_200_2011_Subset20classes/bounding_boxes_fixed.txt";
        num = 20;
end

% Read data
image_filenames = getFileContent(image_txt,0);
class_names = getFileContent(class_txt,0);
image_label = getFileContent(image_class_label,1);
train_files = getFileContent(train_txt,0);
test_files = getFileContent(test_txt,0);
val_files = getFileContent(val_txt,0);
bb_data = importdata(bb_txt);

clear userChoice image_txt class_txt image_class_label train_txt test_txt val_txt bb_txt; % removing unnecessary variables

%% Getting images from the images folder

% empty arrays to store images and their corresponding labels
img_all = [];  % for images
img_bb = []; % for images with bounding box
lbl_all = [];  % for corresponding labels

% Reading Images and Labels
for i = 1:numel(image_filenames)
    if mod(i,250) == 0
        disp(i)
    end
    img_path = fullfile(image_folder,image_filenames{i}); % defining full image path

    im = imread(img_path);  % Load the images

    % Extract bounding box coordinates
    x = bb_data(i, 2);
    y = bb_data(i, 3);
    width = bb_data(i, 4);
    height = bb_data(i, 5);

    % Crop the image based on the bounding box
    croppedImg = imcrop(im, [x, y, width, height]);

    % checking for grayscale images.
    if size(im,3) == 1
        im = cat(3,im,im,im);
    end

    % checking for grayscale images.
    if size(croppedImg,3) == 1
        croppedImg = cat(3,croppedImg,croppedImg,croppedImg);
    end

    % resizing images
    im_full = imresize(im,[227,227]);
    im_bb = imresize(croppedImg, [227,227]); 

    % Save the image:
    img_all = cat(4,img_all, im_full);
    img_bb = cat(4,img_bb, im_bb);
    lbl_all = [lbl_all; image_label(i)];

end

clear im i im_full x y width height croppedImg im_bb; % deleting unnecessary variables. 

%% Viewing 16 random images from img with their labels from lbl

disp16(lbl_all, img_all, img_bb, class_names);

clear img lbl ind head i num_img; % deleting unnecessary variables.

%% Experiment 1 - ML with Feature Extraction on Entire Image

clc;
[confMat_exp1,dur_exp1] = experiment1(image_filenames, img_all, lbl_all, train_files, val_files, test_files);

%% Experiment 2 - ML with Feature Extraction on boxed Image

[confMat_exp2,dur_exp2] = experiment1(image_filenames, img_bb, lbl_all, train_files, val_files, test_files);

%% Experiment 3 - Deep Learning on Whole Image

[confMat_exp3,dur_exp3] = experiment2(image_filenames, img_all, lbl_all, train_files, val_files, test_files, num);

%% Experiment 4 - Deep Learning on on boxed Image

[confMat_exp4,dur_exp4] = experiment2(image_filenames, img_bb, lbl_all, train_files, val_files, test_files, num);

%% Calculating Performance Evaluation

[weight_exp1, cor_exp1, inc_exp1] = perfEval(confMat_exp1);
[weight_exp2, cor_exp2, inc_exp2] = perfEval(confMat_exp2);
[weight_exp3, cor_exp3, inc_exp3] = perfEval(confMat_exp3);
[weight_exp4, cor_exp4, inc_exp4] = perfEval(confMat_exp4);

%% Bonus Experiments

[Part1, Part2, Part3, Part4, Part5] = divideData(lbl_all);

clc;
[acc_cv, cor_cv, incor_cv, dur_cv] = bonusExperiments(img_bb, lbl_all, Part1, Part2, Part3, Part4, Part5);
