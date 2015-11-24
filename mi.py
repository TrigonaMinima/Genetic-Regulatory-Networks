import pandas as pd
import numpy as np
import itertools as it
import json

import data_read


def visualization(mappings, genes, graph_file):
    """
    Creates json file for D3 viz in the fixed format. The format is as follows:

    {
        "nodes":[
            {"name": "G1"},
            ...
        ],
        "links":[
            {"source": 0, "target": 1},
            ...
        ]
    }
    """

    graph = {"nodes": [], "links": []}

    nodes = ("G" + pd.Series(range(1, genes + 1)).map(str))
    for gene in nodes:
        temp = {"name": gene}
        graph["nodes"].append(temp)

    for gene in mappings:
        for regulator in mappings[gene]:
            temp = {"source": int(gene), "target": regulator[0]}
            graph["links"].append(temp)

    with open(graph_file, 'w') as f:
        json.dump(graph, f, indent=4)


def mappings_dump(mappings, dump_file):
    """Dumps the mappings to a file names "mappings.json"."""

    with open(dump_file, "w") as f:
        json.dump(mappings, f, sort_keys=True, indent=4)


# TODO: Check the correctness of the algorithm
# (that is counting the number of unique rows in the dataframe).
def entropy(dat):
    """
    Takes in dataframe of any size and returns the shannon's entropy between
    the first column with respect to the remaining columns in the dataframe.

    TODO: Explain the method used implemented here (maybe using an example)
    """

    temp = dat.apply(lambda x: "".join([str(i) for i in x.values]), axis=1)
    counts = temp.value_counts()

    p = pd.Series(list(counts.values))
    p = p / len(dat)
    p = p.apply(lambda x: -1 * x * np.log2(x))

    return p.sum()


# TODO: Change the function to work when data is not converter.
# That'll save us some precious RAM memory and some time.
def M_analysis(dat, K, file1, file2):
    """
    Takes in dataframe and K and creates a list of the genes / pair of
    genes, for each gene, using the mutual information criteria.

    TODO: Explain the process (maybe using an example)
    """
    mappings = {}
    genes = int(len(dat.columns) / 2)

    for k in range(1, K):
        regulators = [list(i) for i in it.combinations(range(genes), k)]
        # print(regulators)

        for gene in range(genes):
            for regulator in regulators:
                h1 = entropy(dat.iloc[:, regulator])
                if h1 and h1 == entropy(dat.iloc[:, [gene + genes] + regulator]):
                    mappings[gene] = mappings.get(gene, []) + [regulator]

    # Dumps the mappings in a file.
    mappings_dump(mappings, file1)

    # Makes the json file for visualization.
    visualization(mappings, genes, file2)


if __name__ == "__main__":
    # Reading the data
    datas = data_read.reading("Data/insilico_timeseries.tsv")

    # Required data to test MI on
    final_dat = data_read.data_conversion(data)
    print("Dataset converted!")

    # Performing Mutual Information on the final dataframe.
    print("MI Analysis initiated...")
    M_analysis(final_dat, 2)
    print("MI Analysis over! Have a look at the mappings in 'Data/mappings.json'")
