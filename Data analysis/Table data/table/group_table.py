from collections import defaultdict


def _group_records_by(records, group_key):
    """
    1. this func only works on one key
    """
    group_result = defaultdict(list)
    for rec in records:
        key = rec[group_key]
        group_result[key].append(rec)

    return group_result


def _group_records_by_keys(records, group_key_list):

    group_result = defaultdict(list)
    for r in records:
        primary_key = {}
        for key in group_key_list:
            primary_key[key] = r[key]

        primary_key = tuple(sorted(primary_key.items()))

        group_result[tuple(primary_key)].append(r)

    return group_result

def group_records_not_by_keys(records, exclude_key_list):

    group_result = defaultdict(list)
    for r in records:
        primary_key = {}
        for key in r.keys():
            if key in exclude_key_list:
                continue
            primary_key[key] = r[key]

        primary_key = tuple(sorted(primary_key.items()))

        group_result[tuple(primary_key)].append(r)

    return group_result

def group_records_by(records, key):
    if type(key) == str:
        return _group_records_by(records, key)
    elif type(key) == list:
        ## check each item as string
        return _group_records_by_keys(records, key)
    else:
        raise Exception()


def group_records_by_v2(records, key):
    if type(key) == str:
        return _group_records_by_keys(records, [key])
    elif type(key) == list:
        ## check each item as string
        return _group_records_by_keys(records, key)
    else:
        raise Exception()


def group_records_by(records, key_name):
    group_result = defaultdict(list)
    for rec in records:
        key = rec[key_name]
        group_result[key].append(rec)

    return group_result



def group_records_by(records, key_name):
    group_result = defaultdict(list)
    for rec in records:
        key = rec[key_name]
        group_result[key].append(rec)

    return group_result


from .merge_record_by_keymap import merge_record_by_keymap
from .merge_keymap_with_otherlist import merge_keymap_with_otherlist
from .get_records_keymap import get_records_keymap
from .get_keygroups import get_keygroups


def group_same_records(records, prop_keys=[]):
    merge_props = records[0].keys()

    result_list = []
    pending = records

    for key in prop_keys:
        key_groups = get_keygroups(pending, key)
        # print(len(key_groups))

        keymap, pending = get_records_keymap(pending, key_groups, key)
        if result_list:
            keymap, result_list = merge_keymap_with_otherlist(
                keymap, result_list, key_groups, key
            )

        result_list.extend(merge_record_by_keymap(keymap, merge_props))

        if not pending:
            break

    return result_list, pending



from algo.clustering import clustering_name_array


def get_keygroups(records, key):
    key_array_list = []
    for item in records:
        key_array_list.append(item[key].split(';'))

    return clustering_name_array(key_array_list)

from collections import defaultdict


def get_records_keymap(records, key_groups, key):

    keymap = defaultdict(list)
    pending = []

    for r in records:
        first_value = r[key].split(';')[0]
        if first_value:
            group = key_groups[first_value]
            group_key = group[0]
            keymap[group_key].append(r)
        else:
            pending.append(r)

    return keymap, pending


def merge_keymap_with_otherlist(keymap, keylist, key_groups, key):

    new_keylist = []
    for r in keylist:
        if key == 'doi':
            key_list = [r[key]]
        else:
            key_list = r[key].split(';')
        key_list = [i for i in key_list if i.strip()]
        if not key_list:
            new_keylist.append(r)
            continue
        find_group = False
        for k in key_list:
            group = key_groups.get(k)
            if group:
                group_key = group[0]
                keymap[group_key].append(r)
                find_group = True
                break
        if not find_group:
            new_keylist.append(r)

    return keymap, new_keylist


from collections import defaultdict


def merge_record_by_keymap(key_map, merge_props):
    result = []

    for record_list in key_map.values():
        new_record_set = defaultdict(set)
        for record in record_list:
            for prop in merge_props:
                if not record[prop]:
                    new_record_set[prop].add('')
                else:
                    new_record_set[prop].add(record[prop])

        new_record = {}
        for k, v in new_record_set.items():
            new_record[k] = ';'.join([i for i in sorted(list(v)) if i])

        result.append(new_record)

    return result


def _group_records_by(records, group_key):
    """
    1. this func only works on one key
    """
    group_result = defaultdict(list)
    for rec in records:
        key = rec[group_key]
        group_result[key].append(rec)

    return group_result


def _group_records_by_keys(records, group_key_list):

    group_result = defaultdict(list)
    for r in records:
        primary_key = {}
        for key in group_key_list:
            primary_key[key] = r[key]

        primary_key = tuple(sorted(primary_key.items()))

        group_result[tuple(primary_key)].append(r)

    return group_result

def group_records_not_by_keys(records, exclude_key_list):

    group_result = defaultdict(list)
    for r in records:
        primary_key = {}
        for key in r.keys():
            if key in exclude_key_list:
                continue
            primary_key[key] = r[key]

        primary_key = tuple(sorted(primary_key.items()))

        group_result[tuple(primary_key)].append(r)

    return group_result

def group_records_by(records, key):
    if type(key) == str:
        return _group_records_by(records, key)
    elif type(key) == list:
        ## check each item as string
        return _group_records_by_keys(records, key)
    else:
        raise Exception()


def group_records_by_v2(records, key):
    if type(key) == str:
        return _group_records_by_keys(records, [key])
    elif type(key) == list:
        ## check each item as string
        return _group_records_by_keys(records, key)
    else:
        raise Exception()


# the issue is the key
def group_records_by_keys(records, group_key_list, tuple_key=False):
    if type(group_key_list) != list:
        group_key_list = [group_key_list]
    group_key = namedtuple('group_key', group_key_list)

    group_result = defaultdict(list)
    for r in records:
        primary_key = []
        for key in group_key_list:
            primary_key.append(r[key])

        primary_key = group_key(*primary_key)

        if tuple_key:
            primary_key = tuple(primary_key)

        group_result[primary_key].append(r)

    return group_result



def group_records_by(records, group_key_list):

    if not isinstance(group_key_list, list):
        group_key_list = [group_key_list]

    group_result = defaultdict(list)
    for r in records:
        primary_key = {}
        for key in group_key_list:
            primary_key[key] = r[key]

        if len(primary_key) == 1:
            primary_key = list(primary_key.values())[0]
        else:
            primary_key = tuple(sorted(primary_key.items()))

        group_result[primary_key].append(r)

    for k, v in group_result.items():
        yield k, v


