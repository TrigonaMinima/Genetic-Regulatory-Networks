import json

data = []
with open('Data/mappings.json') as f:
    for line in f:
        data.append(json.loads(line))

print(data)