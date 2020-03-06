function node = build_tree(X, y, opts, depth)
    % BUILD_TREE build a single decision tree
    %   node = BUILD_TREE(X, y, opts, depth=1) builds a decision tree on the
    %     training data X (num_data x num_features) and y (num_data x 1).
    %     Returns the root of the tree. The root can be used to call the
    %     predict_tree function.
    %
    %   opts: Hyperparametrs and training flags. Refer to default_opts.m for
    %     the hyper parameters.
    %
    %   depth: Current depth of the tree. For recursive calls.
    %   
    %   node: A single node is a struct the following attributes:
    %     is_leaf,
    %     probs (if is_leaf),
    %     left, right, value, dim (if not is_leaf)

    % Determine dimensions
    [n_samples n_features] = size(X);
  
    if nargin < 4
        depth = 1;
    end
  
    n_classes = opts.n_classes;
    max_depth = opts.max_depth;
    min_leaf_num = opts.min_leaf_num;
    min_entropy = opts.min_entropy;
  
    % Return if not enough data left or data is pure enough
    H = entropy(y, opts);
    if (n_samples < min_leaf_num || H < min_entropy || depth > max_depth)
        node = create_leaf(y, opts);
        strp = sprintf('%.4f, ', node.probs);
        if (opts.debug)
            fprintf(...
            'Num: %5d\t Entropy: %.4f\t Depth: %2d\t Prob: [%s]\n',...
            n_samples, H, depth, strp);
        end
        return
    end
  
    % Find the optimal split, repeat if no information gain
    for i = 1:opts.split_retry
        [split_dim, split_value, max_info_gain] = find_split(X, y, opts);
        assert(max_info_gain >= 0, 'Info gain should be non-negative');
        if (max_info_gain > 0)
            break;
        end
    end
  
    % Print stats
    I = X(:, split_dim) <= split_value;
    if (opts.debug)
        fprintf(...
        'Info gain: %.4f\t Dim: %5d\t Split size: (%d, %d)\t Depth: %2d\n',...
        max_info_gain, split_dim, sum(I), sum(~I), depth);
    end
  
    % Create an internal node
    node = {};
    node.is_leaf = false;
    node.dim = split_dim;
    node.value = split_value;
  
    % Recursively build the tree
    node.left = build_tree(X(I, :), y(I), opts, depth+1);
    node.right = build_tree(X(~I, :), y(~I), opts, depth+1);
end

function node = create_leaf(y, opts)
    % node = CREATE_LEAF(y, opts)
    %   create a single leaf of the decision tree given the ground-truth
    %   by estimating a multinomial distribution.

    n_classes = opts.n_classes;
    n_samples = size(y, 1);
    node = {};
    node.is_leaf = true;
    node.probs = histcounts(y, 1:n_classes+1) / n_samples;
end
