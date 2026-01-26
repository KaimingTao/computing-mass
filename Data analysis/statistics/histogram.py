from collections import defaultdict


def make_histogram(key_list_mapper):
    length_mapper = {}

    for k, l in key_list_mapper.items():
        length_mapper[k] = len(l)

    histogram = defaultdict(list)
    for k, v in length_mapper.items():
        histogram[v].append(k)

    return histogram


def print_histogram(histogram):
    for k, v in sorted(
            histogram.items(),
            key=lambda x: x[0],
            reverse=True):
        print('#hit:', k, '/', '#item:', len(v))
