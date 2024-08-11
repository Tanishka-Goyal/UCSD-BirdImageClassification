function confMat = deepLearningAlgo(set_train, set_val, set_test, num)

net = alexnet;

% Modify the last layers to match the number of classes in the dataset
numClasses = num; % Update this with the number of classes in the dataset

layers = net.Layers(1:end-3);

% Add new fully connected layer with the appropriate number of output classes
fc = fullyConnectedLayer(numClasses, 'Name', 'fc', 'WeightLearnRateFactor', 10, 'BiasLearnRateFactor', 10);
fc.Weights = randn([numClasses, 4096])*0.0001; % Initialize weights
fc.Bias = randn([numClasses, 1])*0.0001; % Initialize bias

layers(end+1) = fc;

% Add softmax layer
layers(end+1) = softmaxLayer('Name', 'softmax');

% Add classification layer with specified classes
classes = categorical(1:numClasses);
layers(end+1) = classificationLayer('Name', 'classoutput', 'Classes', classes);

% Create the new network
net = assembleNetwork(layers);

% Specify training options
options = trainingOptions('sgdm', ...
    'MiniBatchSize', 32, ...
    'MaxEpochs', 10, ...
    'InitialLearnRate', 1e-3, ...
    'Shuffle', 'every-epoch', ...
    'ValidationData', {set_val.images, categorical(set_val.label)}, ...
    'ValidationFrequency', 10, ...
    'Verbose', true, ...
    'Plots', 'training-progress');
% Training the network
trainedNet = trainNetwork(set_train.images, categorical(set_train.label), layers, options);

% Evaluate the trained network on the test set
predictedLabels = classify(trainedNet, set_test.images);

% Creating a Confusion Metrix
confMat = confusionmat(categorical(set_test.label), predictedLabels);

end