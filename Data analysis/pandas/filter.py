df[df['A'] != 'A']

## multiple condition

df[
    (df['A'] != 'A') &
    (df['A'] != 'B') &
    (df['A'] != 'C')]
