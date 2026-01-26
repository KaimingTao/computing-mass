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


def group_records_by(records, key):
    if type(key) == str:
        return _group_records_by(records, key)
    elif type(key) == list:
        # check each item as string
        return _group_records_by_keys(records, key)
    else:
        raise Exception()


def get_enum(key):
    def inner(records):
        unique_gender = set()
        for rec in records:
            gender = rec[key]
            unique_gender.add(gender)

        results = []
        for gender in unique_gender:
            results.append({key: gender})
        return results

    inner.__name__ = 'get_enum_{}'.format(key.lower())

    return inner
