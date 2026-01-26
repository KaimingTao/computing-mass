# replace value

df['a'].replace('b', 'C')

# apply change on column

df['a'].apply(lambda x: x)

# count values

df['A'].value_counts().sort_index()

# pcnt of values

df['A'].value_counts(normalize=True).round(5)

# mean median iqr
df['A'].median()
df['A'].min()
df['A'].max()
df['A'].quantile(0.75)
df['A'].quantile(0.25)
np.percentile(df['A'], [25, 75])

# fillna

df.fillna(0)

# copy

df.copy()

# divide to series especially the aggregated data
# as long as the two series's index are aligned, otherwise the value
# will be NaN
group = df.groupby(['B', 'C'])['count'].sum()
total = group.groupby('B')['count'].transform('sum')

(group / total * 100).round(3)
