# normal Distribution
y = rnorm(25)
plot(y)

x = 1:25
plot(x,y)

# histogram
hist(y)

sum(y)
sum(y)/25
mean(y)
hist(y)
abline(v=mean(y), col="red")

# median
median(y)

# standard deviation
sd(y)