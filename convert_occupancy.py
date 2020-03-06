import pandas as pd
import scipy.io as sio


def read_data(filename):
    data = pd.read_csv(filename)
    s = pd.to_datetime(data[data.keys()[0]])
    s = (s - s.min()).dt.total_seconds()
    data[data.keys()[0]] = s
    data = data.values
    X = data[:, :6]
    y = data[:, 6:7]+1
    print(X.shape)
    print(y.shape)
    return X, y


if __name__ == '__main__':
    Xtr, Ytr = read_data('data/occupancy/datatraining.txt')
    Xte, Yte = read_data('data/occupancy/datatest.txt')
    Xte2, Yte2 = read_data('data/occupancy/datatest2.txt')
    sio.savemat('data/occupancy.mat',
                {'Xtr': Xtr, 'Ytr': Ytr,
                 'Xte': Xte, 'Yte': Yte,
                 'Xte2': Xte2, 'Yte2': Yte2},
                do_compression=True)
