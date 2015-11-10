import pandas as pd
import numpy as np
import itertools as it
import json

import data_read

adjacency = [[0 for x in range(10)] for x in range(10)]

def admatrix(mappings):
    """Creates adjacency matrix by analysing the mapings dictionary"""

    for gen, regs in mappings.items():
        for reg in regs:
            if(len(reg) == 1):
                adjacency[reg[0]][gen] = 1
            else:
                for obj in reg:
                    adjacency[obj][gen] = 1


def mappings_dump(mappings):
    """Dumps the mappings to a file names "mappings.json"."""

    dump_file = "Data/mappings.json"
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
def M_analysis(dat, K):
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

    #print(mappings)
    
    admatrix(mappings)  #Create adjacency matrix 
    
    i = 20
    while(i>10):        #Print adjacency in martrix form
        
        print(adjacency[i])
        i = i - 1
    #print(json.dumps(mappings, indent=4, sort_keys=True))
    
    mappings_dump(mappings)


if __name__ == "__main__":
    # first set of observations loaded
    data = pd.read_table("Data/insilico_timeseries.tsv",
                         nrows=21, index_col="Time")
    print("Dataset loaded!")

    # Required data to test MI on
    final_dat = data_read.data_conversion(data)
    print("Dataset converted!")

    # Performing Mutual Information on the final dataframe.
    print("MI Analysis initiated...")
    M_analysis(final_dat, 3)
    print("MI Analysis over! Have a look at the mappings in 'Data/mappings.json'")
