function [weight_acc, class_correct, class_incorrect] = perfEval(confMat)

% Calculating Class Weighted Accuracy
totalSamples = sum(sum(confMat));
classWeights = sum(confMat, 2) / totalSamples;
classAccuracies = diag(confMat) ./ sum(confMat, 2);
weight_acc = sum(classWeights .* classAccuracies);

% Calculating Class Correct Rate
class_correct = diag(confMat) ./ sum(confMat, 2);

% Calculating Class Incorrect Rate
class_incorrect = (sum(confMat, 1)' - diag(confMat)) ./ sum(confMat, 2);

end