from collections import defaultdict
from algo.clustering import clustering_name_array
from ds.string_ds import remove_punc


def merge_by_column(group_list, column, no_punc=False):
    key_groups_list = []
    yes_key_list = []
    no_key_list = []

    for r_list in group_list:
        keys = [r[column] for r in r_list]
        keys = [k.lower() for k in keys]
        keys = [i.strip() for i in keys]

        keys = ['' if k == 'none' else k for k in keys]

        if no_punc:
            keys = [remove_punc(i) for i in keys]

        keys = [i for i in keys if i]
        if not keys:
            no_key_list.append(r_list)
            continue

        key_groups_list.append(keys)
        yes_key_list.append(r_list)

    key2key_group = clustering_name_array(key_groups_list)

    key_group2records = defaultdict(list)
    for r_list in yes_key_list:
        keys = [r[column] for r in r_list]
        keys = [k.lower() for k in keys]
        keys = [i.strip() for i in keys]

        if no_punc:
            keys = [remove_punc(i) for i in keys]

        keys = [i for i in keys if i]
        key = keys[0]
        key_group = key2key_group[key]
        key_group2records[key_group].extend(r_list)

    return list(key_group2records.values()) + no_key_list
