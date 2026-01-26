# Create
D = data.frame(x = 1:100, y = rnorm(100) , id = letters[1:2])

## Create by manually

employee <- c('John Doe','Peter Gynn','Jolie Hope')
salary <- c(21000, 23400, 26800)
startdate <- as.Date(c('2010-11-1','2008-3-25','2007-3-14'))
employ.data <- data.frame(employee, salary, startdate)

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
