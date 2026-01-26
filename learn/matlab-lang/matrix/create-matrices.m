% scalar
x = 4;

% vector
% row vector
x = [4 5]
% column vector
x = [4;5]

% matrix
x = [5 6 7;8 9 10]
x = [
    1,2,3
    4,5,6
    7,8,9
]

% create matrix with function elements
x = [sqrt(10) pi^2]
x = [
    -8 3+4*5 exp(0)
    (2+3)/3 1+1 2/2
]

% even spaced vector
x = [1 2 3]
x = 1:3
%% know steps
x = 1:0.5:5
x = 3:2:13
%% if you know how many elements should be
x = linspace(1, 10, 5)
logspace(0, 2, 11)

% combine vectors
x = 1:3
y = 2:4
z = [x y]

x = [1:2:10 3 4 5]

%% convert row to column
x = 1:3
x = x'
x = (5:2:9)'

% using function
%% random
x = rand(2)
x = rand(2, 5)
x = randi([1,20], 5, 7)
%% zero matrix
x = zeros(3, 4)
%% others
zeros(3,3)
ones(3,3)
eye(3,3)
rand(4,3)
magic(3)
pascal(4)