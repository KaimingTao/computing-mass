# Create
D = data.frame(x = 1:100, y = rnorm(100) , id = letters[1:2])

# Indexing
## Access element, first index is like list, second is like vector
D[[1]][30]

typeof(D[["y"]])    # double
typeof(D["y"])      # list
typeof(D[[2]])      # double
typeof(D[2])        # list
typeof(D$y)         # double

## get a column
D$id


# Subsetting
D.sub = subset(D, D$y>0)

subset(D, D$id='a')

# statistical operation
D.means = tapply(D$y, D$id, mean)