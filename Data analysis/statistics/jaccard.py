from itertools import product
from math import nan, isnan
from collections import defaultdict
from statistics import mean, stdev
from matplotlib import pyplot as plt
from math import comb, log
import numpy
import math

pairs = list(product([0, 1], repeat=2))

N = 6
N = 167
c1 = 77
c2 = 36

# groups = list(product(pairs, repeat=N))
# j_score = defaultdict(int)
# j_score_pattern = defaultdict(int)
# j_score_pattern2 = defaultdict(list)


# def calc_j_score(group):

#     rec = [
#         [0, 0],
#         [0, 0],
#     ]

#     for i, j in group:
#         if i and j:
#             rec[0][0] += 1
#         elif i and not j:
#             rec[1][0] += 1
#         elif not i and j:
#             rec[0][1] += 1
#         else:
#             rec[1][1] += 1

#     if (rec[0][0] + rec[1][0] + rec[0][1]) == 0:
#         return nan, rec, group
#     else:
#         return (
#             rec[0][0] / (rec[0][0] + rec[1][0] + rec[0][1])), rec, group

# print(len(groups))
# for i in groups:
#     js, mat, grp = calc_j_score(i)
#     j_score[js] += 1
#     mat2 = (mat[0][0], mat[0][1], mat[1][0], mat[1][1])

#     j_score_pattern[mat2] += 1
#     j_score_pattern2[mat2].append(grp)

# print(j_score)

# print('weighted mean')

# x = []
# idx = 0
# y = []
# for i, j in j_score.items():
#     if not isnan(i):
#         for k in range(j):
#             idx += 1
#             x.append(idx)
#         y.extend([i] * j)

# print(mean(y), stdev(y))
# plt.hist(y, bins=len(j_score))
# plt.show()

# print(len(j_score_pattern), 'patterns')
# j_score_pattern_m = [
#     (i, j)
#     for i, j in j_score_pattern.items()
# ]

# j_score_pattern_m.sort(key=lambda x: x[0])

# for i, j in j_score_pattern_m:
#     print(i, j, j / len(groups))

# p = (1,1, 0, N-2)

# print(
#     p,
#     j_score_pattern[p],
#     len(groups),
#     j_score_pattern[p] / len(groups))
# for v in j_score_pattern2[p]:
#     print(v)



# # def add_perm(n=1000, m=4):
# #     perm = set()
# #     for i, j, k in product(list(range(0, n + 1)), repeat=(m - 1)):
# #         if (i + j + k) > n:
# #             continue
# #         l = n - i - j - k
# #         perm.add((i, j, k, l))

# #     print(len(perm))

# # add_perm()

# print(comb(167, 0) * comb(10, 25) * comb(78, 25) / (4 ** 167))


## TODO max jaccard score corresponding pair number for frequency


# jaccard = a / (c1 + c2 - a)
# a + b1 = c1
# a + b2 = c2


# print('perm')

x = []
y = []

values = []
weights = []


for a in range(c1 + c2):
    if a > c1 or a > c2:
        continue
    j = a / (c1 + c2 - a)

    if isnan(j):
        continue

    j = a / (c1 + c2 - a)

    # if j > 1:
    #     continue
    # if a > c1 or a > c2:
    #     continue
    b1 = c1 - a
    b2 = c2 - a

    perm = comb(N, a) * comb(N-a, b1) * comb(N-a-b1, b2)

    print(j, a, perm)

    x.append(j)
    y.append(perm)

    values.append(j)
    weights.append(perm)

total = sum(y)
y = [
    i / total
    for i in y
]


# def weighted_avg_and_std(values, weights):
#     """
#     Return the weighted average and standard deviation.

#     values, weights -- Numpy ndarrays with the same shape.
#     """
#     average = numpy.average(values, weights=weights)
#     # Fast and numerically precise:
#     variance = numpy.average((values-average)**2, weights=weights)
#     return (average, math.sqrt(variance))


# print(weighted_avg_and_std(numpy.array(values), numpy.array(weights)))

plt.scatter(x, y)
plt.show()


def get_jarccart_score(a, b):
    a = set(a)
    b = set(b)
    inter = set(a) & set(b)
    union = set(a) | set(b)
    if len(union) == 0:
        return None
    return len(inter) / len(union)
