function [confMat, dur] = experiment2(image_filenames, img_all, lbl_all, train_files, val_files, test_files, num)

tstart = tic;
% Splitting data into train-val-test sets
[set_train, set_val, set_test] = splitData(image_filenames, img_all, lbl_all, train_files, val_files, test_files);

% Train a DL model
confMat = deepLearningAlgo(set_train, set_val, set_test, num);

dur = toc(tstart);

end