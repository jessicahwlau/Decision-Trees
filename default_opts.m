function opts0 = default_opts()
% DEFAULT_OPTS Returns a struct filled with default parameters for a forest.

opts0 = {};

% Set this flag to print additional debugging info
opts0.debug = false;

% Tree options
opts0.n_classes = 2;  % Number of class labels
opts0.max_depth = 10;  % Maximum depth of a decision tree
opts0.min_leaf_num = 10;  % Minimum number of data left before creating a leaf
opts0.min_entropy = 0.001;  % Minimum entropy to make a leaf
opts0.split_retry = 10;  % Number of retries if no split had non-zero info-gain

% Forest options
opts0.num_trees = 1;
opts0.feats_percent = .9;  % Percent of features used for each tree
opts0.data_percent = .5;  % Perceent of training data used for each tree
