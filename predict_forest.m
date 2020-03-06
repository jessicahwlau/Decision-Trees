function p_forest = predict_forest(X, forest)
% PREDICT_FOREST Predict the probability of labels using a random forest by
% averaging the predictions of individual decision trees.

fprintf('Predicting data: %s\n', sprintf('%d, ', size(X)));
p_forest = [];
for i = 1:size(forest.nodes, 1)
    tree = forest.nodes(i);
    feat_ids = forest.feat_ids(i, :);
    X_sub = X(:, feat_ids);
    p = predict_tree(X_sub, tree);
    p_forest = cat(3, p_forest, p);
end
p_forest = mean(p_forest, 3);
