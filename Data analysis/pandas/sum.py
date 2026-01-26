# sum NA

unknown_a = df['a'].isna().sum()

# diff two rows

(df['a'] - df['b']).dropna().astype(int)
