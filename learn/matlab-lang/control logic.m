% if statements
A = randn(1)
if A > 0
    B = sqrt(A)
end

% if else statement
A = randn(1)
if A > 0
    B = sqrt(A)
else
    B = 0
end

% for loop
for i = 1:3
    disp(i)
end

x = (11:15).^2;
for idx = 1:5
    disp(x(idx))
end