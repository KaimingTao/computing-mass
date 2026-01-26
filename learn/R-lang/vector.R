# create
myvec=c(1,5,6,223,5,16)

# operations
sort(myvec)
rev(myvec)
duplicated(myvec)
head(y) # first 6 elements

# indexing
myvec[1]
myvec[3]

# Coercion
multiples = c(6.5,TRUE,"apple")
typeof(multiples)

multi = c(17L, 16+4i, 84.2, FALSE)
typeof(multi)

# Matrix
## Vector create matrix
mymat=matrix(myvec,nrow=2)

mymat=matrix(myvec,nrow=3)

## Transposition
tmat=t(mymat)

## matrix operation
summat=mymat+mymat
prodmat=mymat %*% tmat
mymat.means = apply(mymat, 2, mean) # mean of columns

## Indexing
summat[1,1]
