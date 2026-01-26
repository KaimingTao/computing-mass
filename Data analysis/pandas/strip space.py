def strip_space(v):
    return v.strip() if isinstance(v, str) else v

df['columnname'].apply(strip_space)
