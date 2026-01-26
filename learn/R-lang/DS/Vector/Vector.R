# create vector
v <- c(1,5,6,223,5,16)

a <- 32
v2 <- c(1,2,3,4,a, 1e+03)

# show first 6 elements
head(y)

# indexing
v[1]
v[3]

# concat

v3 = c(v, v2)

# creat sequence

a <- 3:27
b <- seq(from=3, to=27, by=3)

# create sequence evenly spaced
c <- seq(from=3, to=27, length.out=40)

# repeat
a <- rep(x=1, times=4)
b <- rep(x=c(3,62,8.3),times=3)
rep(x=c(3,62,8.3),each=2)
rep(x=c(3,62,8.3),times=3,each=2)

# sort
sort(x=c(2.5,-1,-10,3.44),decreasing=FALSE)


rev(v)
duplicated(v)



# Coercion
multiples <- c(6.5,TRUE,"apple")
typeof(multiples)

multi <- c(17L, 16+4i, 84.2, FALSE)
typeof(multi)

