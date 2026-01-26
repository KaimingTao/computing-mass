a = [2 -4 7];
p = poly(a)
poly2str(p, 'x')
roots(p)

% convolution
a = [1 3 5];
b = [2 4 6];
c = conv(a,b)
[q, r] = deconv(c, a)

X = 0:1:10;
p = [2, 3, 5]
Y = polyval(p, X)
plot(X, Y)

a = [1 3 5]
b = [2 4 6]
polyder(a)
polyder(b)
polyder(a, b)
[q, d] = polyder(a, b)


% 拟合

x = [1 2 3 4 5]
y = [3.2 46.7 138.2 278.6 467.2];
polyfit(x, y, 3)
ploy(x, y)

% 差值
x = 1:12
y = [5 8 9 13 27 29 31 29 21 25 28 23];
a = interp1(x, y, 9.3)
b = interp1(x, y, 4.8)

% 展开
a = [1 2 2 1];
b = [1 4 4 2 1];
[r l k] = residue(a, b)