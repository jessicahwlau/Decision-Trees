# Decision Trees
- entropy computes the entropy of the distribution over class labels given a dataset with labels y
- find_split chooses a random feature dimension of the input vector, sorts data points according to the value of the selected feature, and evaluates the information gain for hypothetical split thresholds
- build_forest builds a random forest, a set of decision trees learned on random subsets of data and features
- test_examples enables debugging using simple synthetic examples
