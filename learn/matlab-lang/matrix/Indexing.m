% access single element
X = A(3, 4)
x = data(end, 3)
y = A(end-1, end-1)

% all rows or all columns
x = A(2, :)
y = A(:, 3)
%% part of rows or columns
x = A(1:3, :)
volumes = data(:, end-1:end)

% vector, no matter is row or column vector
x = v(3)
%% range of vector
x = v(3:end)

% logical indexing
v = v1(v1 > 6)
s = sample(v1 < 4)
%% reassignment
x(x==999) = 0
v1(v1 > 5) = 10