function p = predict_tree(X, node)
% PREDICT_TREE Predict the probability of labels using a decision tree.

if(numel(X) == 0)
    p = [];
    return
end
if(node.is_leaf)
    % Leaf node, return probabilities
    p = repmat(node.probs, size(X, 1), 1);
    return
end
% Internal node, follow the left node if <=
I = X(:,node.dim) <= node.value;

% Follow left sub-tree
pl = predict_tree(X(I,:), node.left);

% Follow right sub-tree
pr = predict_tree(X(~I,:), node.right);

p = zeros(size(X, 1), max(size(pr, 2), size(pl, 2)));
p(I, :) = pl;
p(~I, :) = pr;
