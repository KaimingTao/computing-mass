## groupby won't do calculation


## dont use group key as index
df.groupby(['a', 'b'], as_index=False)

## agg function

## one row per group for sum
df.groupby(['a', 'b']).agg('sum')
df.groupby(['a', 'b']).sum()

## all row has sum, spread to each row for ratio calculation

df.groupby(['a', 'b']).transform("sum")

## rename sum

df.groupby(['a', 'b']).sum().rename('total')

## reindex by another series
df.reindex(series.index, fill_value=0)

## get index as servies

df.index
