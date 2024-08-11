function confMat = trainHogKNN(set_train_sub, set_val_sub, set_test_sub)
    % Initialize variables to store HOG features and corresponding labels
    features_train = [];
    labels_train = [];

    % Extract HOG features for training set
    for i = 1:numel(set_train_sub.label)
        % Extract HOG features
        hog_feature = extractHOGFeatures(rgb2gray(set_train_sub.images(:,:,:,i)));
        
        % Store features and labels
        features_train = [features_train; hog_feature];
        labels_train = [labels_train; set_train_sub.label(i)];
    end
    
    
    for i = 1:numel(set_val_sub.label)
        % Extract HOG features for validation set
        hog_feature = extractHOGFeatures(rgb2gray(set_val_sub.images(:,:,:,i)));
        
        % Store features and labels
        features_train = [features_train; hog_feature];
        labels_train = [labels_train; set_val_sub.label(i)];
    end
    

    % Train k-NN classifier
    model_knn = fitcknn(features_train, labels_train);

    % Test model using testing set
    features_test = [];
    labels_test = [];
    for i = 1:numel(set_test_sub.label)
        % Extract HOG features
        hog_feature = extractHOGFeatures(rgb2gray(set_test_sub.images(:,:,:,i)));

        % Store values
        features_test = [features_test;hog_feature];
        labels_test = [labels_test;set_test_sub.label(i)];
    end

    % Predict labels for testing set
    pred_labels = predict(model_knn,features_test);

    % Creating a Confusion Metrix
    confMat = confusionmat(set_test_sub.label, pred_labels);
    
end
