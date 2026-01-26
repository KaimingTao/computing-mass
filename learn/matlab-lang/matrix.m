x = [2:-1:1];
y = x*2;
z = sqrt(x);
B = [x y z]

%complex matrix
R = [2,4,6;7,8,9];
I = R*2;
F = R + I*j


% slice
A = rand(3)
B = A(1,:)
C = A(:, [2,3])
D = A(:,:)

A = rand(3)
b = 0.5;
k = A>=b
C = A(k)

% transform
A = rand(3, 3)
B = rot90(A, 3)
C = fliplr(A)
D = flipud(A)

E = diag(A)
F = triu(A, 1)
G = triu(A, -1)

% operations
A = [23 4 5; 6 7 60; 20 45 78];
B = [4 90 2; 56 64 4; 0 10 30];
A + B
A - B
k = 9
A - k
k = 2
A * k
A^0.3
(0.5)^A

v = [-1;4;5]
x = v'
z = [i+i 3-2i]
z'
z.'
conj(z')

% differential equation dx/dt=Ax, x(0) = [1;1;1]
a = [
    -1,0,0;
    -2,0,0;
    0,0,-3;
]
x0 = [1;1;1];
t=0:0.1:1.0;
for i = 1:length(t)
    x(:,i) = expm(a*t(i))*x0
end
plot3(x(1,:), x(2,:),x(3,:))
grid on

% operations

A = rand(3);
expm(A)
logm(A)
det(A)
n1 = norm(A, 1)
n2 = norm(A, 2)
ninf = norm(A, inf)

% 矩阵分解
chol(pascal(6))

X = [2 4 6; 7 9 3; 5 8 7]
[L, U] = lu(X)
d = del(L) * del(U)

X = [2 4 6; 1 3 5; 7 9 11; 6 8 10];
[Q, R] = qr(X)

a = [1 2 2; 1 2 1; 3 5 2]
[X, D] = eig(a)

A = [34 56;78 91]
[U, S, V] = svd(A)

A = [3 4 6; 5 8 9; 4 5 3]
X = pinv(A)
Q = X * A

% 稀疏矩阵
sm = sparse([1 2 3 4 5], [5 4 3 2 1], [2 4 6 8 10], 5, 5)
A = [0 0 0 0 4; 0 0 3 0 0];
sparse(A)
spdiags
load T.dat
spconvert(T)