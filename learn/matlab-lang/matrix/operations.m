% scala add
y = x + 2
z = x * y
a = 2/x

% math operations on vector
x = sqrt(v)
y = round(v)

% matrix
%% dot multiplication
z = [3 4] .* [10 20]

% size operation
%% array
s = size(x)
%% matrix
d = size(density)
[xrol xcol] = size(x)

% relational operations
pi > 3
[5 10 15] > 12
[5 10 15] > [6 9 20]

% logical operators
x = (pi > 5) & (0 < 6)
test = (pi > 3) & (x > 0.9)