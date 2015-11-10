import pandas as pd
import numpy as np

import data_read


def entropy(dat, col1=None):
    temp = dat.apply(lambda x: "".join([str(i) for i in x.values]), axis=1)
    counts = temp.value_counts()

    p = pd.Series(list(counts.values))
    p = p / len(dat)
    p = p.apply(lambda x: -1 * x * np.log(x))

    return p.sum()


# def entropy(dat, col1, col2):
#     # print(dat)
#     table = dat.pivot_table(index=[col1], columns=[col2], aggfunc=len)
#     total = len(dat)

#     # print(table.shape)

#     if table.shape == (2, 2):
#         p = pd.Series([table[0][0], table[0][1], table[1][0], table[1][1]])
#     else:
#         p = pd.Series(
#             [handle_bad_cases(table, i, j)
#              for i, j in [(0, 0), (0, 1), (1, 0), (1, 1)]]
#         )

#     # p = pd.Series([table[0][0], table[0][1], table[1][0], table[1][1]])
#     p = p / total
#     p = p.apply(lambda x: -1 * x * np.log(x))

#     return p.sum()


# def h(*args):
#     i = 0
#     ent = 0
#     for arg in args:
#         for j in range(0, 20):
#             temp[j][i] = gene[j][arg]
#         i = i + 1

#     i = i - 1
#     t = i

#     while j > -1:
#         i = t
#         while i > -1:
#             samp[j] = samp[j] + temp[j][i]
#             i = i - 1
#         j = j - 1

#     uni = list(set(samp))

#     for c in uni:
#         p = pro(samp, c)
#         ent += p * m.log2(p)

#     return -1 * ent


def M_analysis(dat, K):
    mappings = {}

    genes = int(len(dat.columns) / 2)

    for k in range(K):
        for gene in range(genes):
            col1 = "G" + str(gene + 1) + "_t2"
            for regulator in range(genes):
                col2 = "G" + str(regulator + 1) + "_t1"
                # print(entropy(dat[[col1, col2]], col1, col2),
                #       entropy_one(dat[col2]))

                h1 = entropy(dat.iloc[:, [regulator]])
                if h1 and h1 == entropy(dat.iloc[:, [gene, regulator]]):
                    print(col1, "<-", col2,
                          "[", h1, entropy(dat.iloc[:, [gene, regulator]]), "]")
        break


if __name__ == "__main__":

    # first set of observations loaded
    data = pd.read_table("Data/insilico_timeseries.tsv",
                         nrows=21, index_col="Time")

    # Required data to test MI on
    final_dat = data_read.data_conversion(data)

    # Performing Mutual Information on the final dataframe.
    M_analysis(final_dat, 4)
