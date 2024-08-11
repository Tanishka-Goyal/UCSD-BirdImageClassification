function [confMat, dur] = experiment1(image_filenames, img_all, lbl_all, train_files, val_files, test_files)

tstart = tic;
% Splitting data into train-val-test sets
[set_train, set_val, set_test] = splitData(image_filenames, img_all, lbl_all, train_files, val_files, test_files);

% Training a KNN model with HoG Feature Extraction
confMat = trainHogKNN(set_train, set_val, set_test);

dur = toc(tstart);

end