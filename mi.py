import pandas as pd
import numpy as np
import itertools as it
import json
from collections import OrderedDict

import data_read

# adjacency = [[0 for x in range(10)] for x in range(10)]

# orderDict = collections.OrderedDict()

def visualization (mappings,genes):
    """Creates json file for visualization of the GRN by analysing the mapings dictionary"""

    nod = {'nodes':[], 'links':[]}
    # itm = collections.OrderedDict()
    j = 0
    i = 1

    for i in range(genes+1):
        
        if(i!=10):
            nod["nodes"].append({})
        nod["nodes"][i-1]["name"] = 'G' + str(i)
        i = i + 1


    for gen, regs in mappings.items():
        for reg in regs:

            if(len(reg) == 1):
                count = 0
                flag = 0
                while(count < j):
                    if((nod['links'][count]['source'] == (reg[0] + 1)) and (nod['links'][count]['target'] == (gen + 1))):
                        flag = 1
                        break
                    else:
                        count = count + 1

                if(flag == 0):
                    nod['links'].append({})
                    nod['links'][j]['source'] = reg[0] + 1
                    nod['links'][j]['target'] = gen + 1
                    j = j + 1
                    # adjacency[reg[0]][gen] = 1

            else:
                for obj in reg:

                    count = 0
                    flag = 0
 
                    while(count < j):      
                        if((nod['links'][count]['source'] == (obj + 1)) and (nod['links'][count]['target'] == (gen + 1))):
                            flag = 1
                            break
                        else:
                            count = count + 1

                    if(flag == 0):
                        nod['links'].append({})
                        nod['links'][j]['source'] = obj + 1
                        nod['links'][j]['target'] = gen + 1
                        j = j + 1
                        # adjacency[obj][gen] = 1


    # itm = nod.items()
    # itm.reverse()
    # OrderedDict(itm)    
    itm = OrderedDict(sorted(nod.items(), key=lambda t: t[0], reverse = True))

    print(itm)
    

    with open('Assets/grn.json', 'w') as fp:
        json.dump(itm, fp, indent=2, sort_keys=False)
        # json.dump(nod, fp, indent=2, sort_keys=True)



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
            
            
    visualization(mappings,genes)  

    # Create adjacency matrix

    # i = 0
    # while(i < 10):  # Print adjacency in martrix form
        
    #     print(adjacency[i])
    #     i = i + 1
    # #print(json.dumps(mappings, indent=4, sort_keys=True))

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
