import pandas as pd


def ones(x):
    """Returns one for x > 0.5 else returns 0."""
    if x > 0.5:
        return 1
    return 0


def rename_cols(dat, suffix):
    """
    Changes the column names by appending the suffix to the column names.

    For eg: A column named "G1" with supplied suffix as "_t1", becomes, "G1_t1".
    """
    new_cols = []
    for i in dat.columns:
        new_cols.append(i + suffix)

    dat.columns = new_cols


# TODO: Here a new dataframe is made twice the size of the original one.
# The need for this dataframe can be removed if we directly use the binary
# converted data of the original dataframe.
# We will have to comeup with come logice.
def data_conversion(dat):
    """
    Takes in a time series data frame converts it to a binary type and
    then returns another dataframe with twice as columns as in the
    original dataframe and one row less.

    It also writes the converted dataframe to a separate csv file named
    "final_formatted_data.csv"

    For eg: The following dataframe is converted to the one following it.

    Time G1  G2  G3
    0       1    0    0
    50     0    0    0
    100   0    0    1

    Time G1_t1  G2_t1  G3_t1 G1_t2  G2_t2  G3_t2
    0         1        0        0        0        0         0
    50        0        0        0        0        0         1

    In the above example, values for time = 50 became next 3 row values
    for time=0.
    The converted dataframe is returned by the function.
    """

    # float expressions values converted to dichotomous values
    dicho_d = dat.applymap(lambda x: ones(x))

    temp = dicho_d.iloc[1:]
    rename_cols(temp, "_t2")

    dicho_d = dicho_d.iloc[:-1]
    rename_cols(dicho_d, "_t1")

    temp.index = dicho_d.index
    dicho_d = dicho_d.join(temp)

    dicho_d.to_csv("Data/final_formatted_data.csv")

    return dicho_d


def reading(file):
    # first set of observations loaded
    data = pd.read_table(file, index_col="Time")

    datas = []
    for i in range(0, 5):
        datas.append(data.iloc[i*21: (i+1)*21])

    return(datas)


if __name__ == "__main__":
    # Reading the data
    datas = reading("Data/insilico_timeseries.tsv")

    # Required data to test MI on
    final_dat = data_conversion(data)
