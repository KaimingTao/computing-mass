# Use vector to create matrix
mymat=matrix(myvec,nrow=2)

mymat=matrix(myvec,nrow=3)

# Transposition
tmat=t(mymat)

# matrix operation
summat=mymat+mymat
prodmat=mymat %*% tmat
mymat.means = apply(mymat, 2, mean) # mean of columns

# Indexing
summat[1,1]
