% Train and test on the "Occupancy Detection" dataset
% https://archive.ics.uci.edu/ml/datasets/Occupancy+Detection+
% Load data
load 'data/occupancy'

% Use the first test set as the validation set
Xva = Xte;
Yva = Yte;

% Print dataset info
rng(1234);
fprintf('Training size: [%s]\n', sprintf('%d, ', size(Xtr)));
fprintf('Training data samples:\n');
perm = randperm(size(Xtr, 1));
Xtr(perm(1:10), :)
fprintf('Label size: [%s]\n', sprintf('%d, ', size(Ytr)));
fprintf('Labels samples:\n');
Ytr(perm(1:10))'
rng('default');

opts = occupancy_opts;
opts.n_classes = 2;

% Train and test
root = build_forest(Xtr, Ytr, opts);
ptr = predict_forest(Xtr, root);
pva = predict_forest(Xva, root);

acc_tr = accuracy(ptr, Ytr);
fprintf('Training Accuracy: %.2f\n', acc_tr);
acc_va = accuracy(pva, Yva);
fprintf('Validation Accuracy: %.2f\n', acc_va);

% Uncomment to test on the second test set
Xte = Xte2;
Yte = Yte2;
pte = predict_forest(Xte, root);
acc_te = accuracy(pte, Yte);
fprintf('Test Accuracy: %.2f\n', acc_te);
