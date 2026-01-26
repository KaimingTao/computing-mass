import pandas as pd


df = pd.read_excel('Sheet.xlsx', sheet_name=0)


df = pd.read_excel('Sheet.xlsx', sheet_name='Sheet1')

## drop columns, axis=1 is required
df = df.drop(['a', 'b', 'c', 'd'], axis=1)


## write

df.to_excel(file_name, index=False)
