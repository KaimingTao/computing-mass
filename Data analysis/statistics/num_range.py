

def calc_num_range(num_list):
    if len(num_list) == 0:
        return []

    num_list = sorted(num_list)
    range_list = []
    start = num_list[0]
    stop = num_list[0]
    for i1 in range(len(num_list)):
        i2 = i1 + 1
        if i2 == len(num_list):
            range_list.append((start, stop))
            break
        a = num_list[i1]
        b = num_list[i2]
        if (b - a) == 1:
            stop = b
        else:
            range_list.append((start, stop))
            start = b
            stop = b

    return range_list