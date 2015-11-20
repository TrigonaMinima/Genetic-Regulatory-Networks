import pandas as pd
import numpy as np
import itertools as it
import json
import http.server

import data_read
import mi


# first set of observations loaded
data = pd.read_table("Data/insilico_timeseries.tsv",
                     nrows=21, index_col="Time")
print("Dataset loaded!")

# Required data to test MI on
final_dat = data_read.data_conversion(data)
print("Dataset converted!")

# Performing Mutual Information on the final dataframe.
print("MI Analysis initiated...")
mi.M_analysis(final_dat, 2)
print("MI Analysis over! Have a look at the mappings in 'Data/mappings.json'")

# Setting up the server for the graph viz.
handler = http.server.SimpleHTTPRequestHandler
server = http.server.HTTPServer(('localhost', 8000), handler)
print("\nThe graph visualized at http://localhost:8000/Viz.html")
server.serve_forever()
