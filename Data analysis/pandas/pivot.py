# use B value as column name
df.pivot(index='A', columns='B', values='C').fillna(0)
