function forest = build_forest(X, y, opts)
% BUILD_FOREST Build a random forest.
%   forest = BUILD_FOREST(X, y, opts) builds a random forest given the training
%     data X (num_data x num_features) and labels y (num_data x 1).
%
%     opts: includes hyperparameters for the forest and trees. Refer to
%     default_opts.m.
%
%     forest: struct with two attributes: nodes and feat_ids. nodes is a list
%       if roots of the decision trees. feat_ids is a list where each element
%       is a list of indices of features used in the decision tree.

% Determine dimensions
[n_samples n_features] = size(X);

tree_nfeats = ceil(opts.feats_percent * n_features);
tree_ndata = ceil(opts.data_percent * n_samples);
fprintf('Building forest: #trees: %d, #feats: %d/%d, #data: %d/%d.\n',...
opts.num_trees, tree_nfeats, n_features, tree_ndata, n_samples);

forest = {};
forest.nodes = [];
forest.feat_ids = [];
opts.num_trees
for i = 1:opts.num_trees
    if opts.debug
        fprintf('Building tree %d\n', i);
    end
    % Sample subset of data and features.
    % X_sub, y_sub: selected rows and columns of X, y.
    % Use the randperm function.
    % Store selected feature indices in feat_ids.
    %%%%%%%% BEGIN Student's Code %%%%%%%%%%%%%
    [row, col] = size(X);
    rand_row = randperm(row, tree_ndata);
    rand_col = randperm(col, tree_nfeats);
    X_sub = X(rand_row, rand_col);
    y_sub = y(rand_row);
    feat_ids = rand_col;
    %%%%%%%% END Student's Code %%%%%%%%%%%%%

    tree = build_tree(X_sub, y_sub, opts);

    % Add tree to the forest
    forest.nodes = [forest.nodes; tree];
    forest.feat_ids = [forest.feat_ids; feat_ids];
end
