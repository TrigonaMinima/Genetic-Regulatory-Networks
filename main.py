import pandas as pd
import numpy as np
import itertools as it
import json
import http.server

import data_read
import mi


# Reading the data
datas = data_read.reading("Data/insilico_timeseries.tsv")
# print(datas)

# Required data to test MI on
final_datas = []
for data in datas:
	final_datas.append(data_read.data_conversion(data))
print("Dataset converted!")
# print(final_datas)

# Performing Mutual Information on the final dataframe.
print("MI Analysis initiated...")

for i, final_data in enumerate(final_datas):
	f1 = "Data/mappings" + str(i+1) + ".json"
	f2 = "Assets/grn" + str(i+1) + ".json"
	mi.M_analysis(final_data, 2, f1, f2)
	print("MI Analysis over! Have a look at the mappings in ", f1)

# Setting up the server for the graph viz.
handler = http.server.SimpleHTTPRequestHandler
server = http.server.HTTPServer(('localhost', 8000), handler)
print("\nThe graph visualized at http://localhost:8000/Viz2.html")
server.serve_forever()
