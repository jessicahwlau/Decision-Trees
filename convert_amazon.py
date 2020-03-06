import scipy.io.arff as scif
import scipy.io as sio
import numpy as np

data = scif.loadarff('data/amazon/Amazon_initial_50_30_10000.arff')
X = np.array([list(x)[:-1] for x in data[0]])
B = np.array([list(x)[-1] for x in data[0]])
names, I = np.unique(B, return_index=True)
names = names[np.argsort(I)]
labels = np.zeros((B.shape[0], 1))
for i, n in enumerate(names):
    labels[B == n] = i+1
print(X.shape)
print(X[:10, :10])
print(labels.shape)
print(labels[:10])
nauthors = 50
nreviews = 30
train_test_ratio = 2./15
train_mask = np.mod(np.arange(X.shape[0]), nreviews)
train_mask = train_mask < nreviews*(1-train_test_ratio)
print(train_mask)
print(np.sum(train_mask))

Xtr = X[train_mask, :]
Ytr = labels[train_mask, :]
Xte = X[np.logical_not(train_mask), :]
Yte = labels[np.logical_not(train_mask), :]

sio.savemat('data/amazon.mat',
            {'Xtr': Xtr, 'Ytr': Ytr, 'Xte': Xte, 'Yte': Yte},
            do_compression=True)
