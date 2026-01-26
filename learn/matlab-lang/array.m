% reshape
A = zeros(2,5)
A(:) = -4:5
L = abs(A) > 3
islogical(L)
B = A(L)

% high dimension array
A = zeros(2,3)
A(2,2,2) = 1
B(2,5,:) = 1:3

A = ones(2,3);
A(:,:,2) = ones(2,3) * 2
A(:,:,3) = ones(2,3) * 3

rand('state', 1111), rand(2,4,3)
cat(3, ones(2,3), ones(2,3)*2, ones(2,3)*3)
repmat(ones(2,3), [1,1,3])

A = reshape(1:24, 2, 3, 4)
dim_A = ndims(A)
size_A = size(A)
L_A = length(A)

%% more high
a = rand(1, 1, 3, 1, 2)
[b, n] = shiftdim(a)
c = shiftdim(a, 3)
e = squeeze(a)

% operations
A = [3;5;7;9;]
A' - 2

a = [1 3 5 7 9]
b = [2 4 6 8 10]
a.*b
a./b
a.\b
3.^a
a.^3