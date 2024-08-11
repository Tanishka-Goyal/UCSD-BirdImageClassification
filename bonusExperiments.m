function [acc_cv, cor_cv, incor_cv, dur_cv] = bonusExperiments(img_bb, lbl_all, Part1, Part2, Part3, Part4, Part5)
tstart = tic;
 
num = length(unique(lbl_all));

% combining indices
com123 = [Part1;Part2;Part3];
com234 = [Part2;Part3;Part4];
com345 = [Part3;Part4;Part5];
com451 = [Part4;Part5;Part1];
com512 = [Part5;Part1;Part2];

% Getting the training images from combined indices
train123.images = img_bb(:,:,:,com123);
train234.images = img_bb(:,:,:,com234);
train345.images = img_bb(:,:,:,com345);
train451.images = img_bb(:,:,:,com451);
train512.images = img_bb(:,:,:,com512);

% Storing labels for training
train123.label = lbl_all(com123);
train234.label = lbl_all(com234);
train345.label = lbl_all(com345);
train451.label = lbl_all(com451);
train512.label = lbl_all(com512);

% Train and validation sets for each bonus run
val1.images = img_bb(:,:,:,Part4);
val1.label = lbl_all(Part4);
test1.images = img_bb(:,:,:,Part5);
test1.label = lbl_all(Part5);

val2.images = img_bb(:,:,:,Part5);
val2.label = lbl_all(Part5);
test2.images = img_bb(:,:,:,Part1);
test2.label = lbl_all(Part1);

val3.images = img_bb(:,:,:,Part1);
val3.label = lbl_all(Part1);
test3.images = img_bb(:,:,:,Part2);
test3.label = lbl_all(Part2);

val4.images = img_bb(:,:,:,Part2);
val4.label = lbl_all(Part2);
test4.images = img_bb(:,:,:,Part3);
test4.label = lbl_all(Part3);

val5.images = img_bb(:,:,:,Part3);
val5.label = lbl_all(Part3);
test5.images = img_bb(:,:,:,Part4);
test5.label = lbl_all(Part4);

% Deep Learning Algorithm is run for each combination
cnfMat = deepLearningAlgo(train123, val1, test1,num);
[a1, c1, i1] = perfEval(cnfMat);
cnfMat = deepLearningAlgo(train234, val2, test2,num);
[a2, c2, i2] = perfEval(cnfMat);
cnfMat = deepLearningAlgo(train345, val3, test3,num);
[a3, c3, i3] = perfEval(cnfMat);
cnfMat = deepLearningAlgo(train451, val4, test4,num);
[a4, c4, i4] = perfEval(cnfMat);
cnfMat = deepLearningAlgo(train123, val1, test1,num);
[a5, c5, i5] = perfEval(cnfMat);


% Evaluating Performance
a = [a1;a2;a3;a4;a5];
c = [c1;c2;c3;c4;c5];
i = [i1;i2;i3;i4;i5];

acc_cv = mean(a);
cor_cv = mean(c);
incor_cv = mean(i);

dur_cv = toc(tstart);


end