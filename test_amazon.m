% Train and test on the "Amazon Commerce Reviews" dataset
% https://archive.ics.uci.edu/ml/datasets/Amazon+Commerce+reviews+set
load data/amazon

% Select validation set from the training set
% Modify after hyperparametr tuning to train on the entire training set
rng(4321);
perm = randperm(size(Xtr, 1));
Xva = Xtr(perm(1201:1300), :);
Yva = Ytr(perm(1201:1300), 1);
Xtr = Xtr(perm(1:1200), :);
Ytr = Ytr(perm(1:1200), 1);

% Print dataset info
rng(1234);
fprintf('Training size: [%s]\n', sprintf('%d, ', size(Xtr)));
fprintf('Training data samples:\n');
perm = randperm(size(Xtr, 1));
Xtr(perm(1:10), 1:10)
fprintf('Label size: [%s]\n', sprintf('%d, ', size(Ytr)));
fprintf('Labels samples:\n');
Ytr(perm(1:10))'
rng('default');


opts = amazon_opts;
opts.n_classes = 50;

root = build_forest(Xtr, Ytr, opts);
ptr = predict_forest(Xtr, root);
pva = predict_forest(Xva, root);

acc_tr = accuracy(ptr, Ytr);
fprintf('Training Accuracy: %.2f\n', acc_tr);
acc_va = accuracy(pva, Yva);
fprintf('Validation Accuracy: %.2f\n', acc_va);

% Uncomment to test on the test set
pte = predict_forest(Xte, root);
acc_te = accuracy(pte, Yte);
fprintf('Test Accuracy: %.2f\n', acc_te);
