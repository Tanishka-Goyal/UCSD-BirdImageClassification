function [train_set, val_set, test_set] = splitData(image_filenames, img_all, lbl_all, train, val, test)

% Empty arrays to store indices of train, val, test sets. 
train_ind = [];
val_ind = [];
test_ind = [];

for i = 1:length(train)
    train_ind = [train_ind; find(strcmp(image_filenames, train(i)))];
end

for i = 1:length(val)
    val_ind = [val_ind; find(strcmp(image_filenames, val(i)))];
end

for i = 1:length(test)
    test_ind = [test_ind; find(strcmp(image_filenames, test(i)))];
end

train_set.images = img_all(:,:,:,train_ind);
train_set.label = lbl_all(train_ind);

val_set.images = img_all(:,:,:,val_ind);
val_set.label = lbl_all(val_ind);

test_set.images = img_all(:,:,:,test_ind);
test_set.label = lbl_all(test_ind);

end