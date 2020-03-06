function acc = accuracy(p, y)
% ACCURACY Compute the accuracy of the prediction.
%  acc = ACCURACY(p, y) computes the accuracy of prediction matrix p
%    (num_data x num_labels) given the ground truth labels y
%    (num_data x 1, values in [1.. num_labels]).

[~, t] = max(p, [], 2);
acc = sum(t==y)*100/size(y, 1);
