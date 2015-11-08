import pandas as pd
import math

import data_read


def probab(col, j):
    count = col.value_counts()

    return count[j] / len(col)


def entropy(col):
    p_one = probab(col, 1)
    p_zero = probab(col, 0)

    if p_one == p_zero:
        return 1.0

    h = -1 * p_one * math.log(p_one)
    h += -1 * p_one * math.log(p_one)

    return h


def h(*args):
    i = 0
    ent = 0
    for arg in args:
        for j in range(0, 20):
            temp[j][i] = gene[j][arg]
        i = i + 1

    i = i - 1
    t = i

    while j > -1:
        i = t
        while i > -1:
            samp[j] = samp[j] + temp[j][i]
            i = i - 1
        j = j - 1

    uni = list(set(samp))

    for c in uni:
        p = pro(samp, c)
        ent += p * m.log2(p)

    return -1 * ent


def M_analysis(dat, K):
    mappings = {}

    genes = len(dat.columns) / 2

    for k in range(K):
        for gene in range(genes):
            pass

    # for j in range(11, 21):
    #     for i in range(0, 10):
    #         if(h(i) == h(j, i)):
    #             print(h(i))
    #             print("%d is determined by %d" % (i, j))


if __name__ == "__main__":

    # first set of observations loaded
    data = pd.read_table("Data/insilico_timeseries.tsv",
                         nrows=21, index_col="Time")

    # Required data to test MI on
    final_dat = data_read.data_conversion(data)

    # Performing Mutual Information on the final dataframe.
    M_analysis(final_dat, 4)
