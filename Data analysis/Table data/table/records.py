# Helper functions
# TODO, trim listed columns
def trim_records(records):
    for record in records:
        for k, v in record.items():
            record[k] = v.strip()

    return records


def remove_blank_row(records):
    return list(filter(lambda x: x, records))


def is_blank_value(value):
    if not value:
        return True
    if value.upper() == 'ND':
        return True
    if value.upper() == 'N/A':
        return True
    if value.upper() == 'NA':
        return True
    return False



def find_all_keys(dict_obj, keyname, ignore_case=True):
    sub_dicts = [dict_obj]
    if ignore_case and type(keyname) == str:
        keyname = keyname.lower()

    while len(sub_dicts) > 0:
        new_sub_dicts = []
        for d in sub_dicts:
            for k, v in d.items():
                if ignore_case and type(k) == str:
                    k = k.lower()
                if k == keyname:
                    yield k, v
                elif type(v) == dict:
                    new_sub_dicts.append(v)
        sub_dicts = new_sub_dicts


def merge_dict(dict1, dict2, null_values=[None], keys={}):
    keys1 = dict1.keys()
    keys2 = dict2.keys()
    if not keys:
        keys = set(list(keys1) + list(keys2))
    result = {}
    for key in keys:
        v1 = dict1.get(key)
        v2 = dict2.get(key)
        if v2 not in null_values:
            value = v2
        else:
            value = v1
        result[key] = value

    return result



def concate_list(lists):
    result = []
    for item in lists:
        result.extend(item)
    return result


def flatten(lists):
    return [i for j in lists for i in j]


import re

def split_strip(string, spliter):
    string = string.split(spliter)
    return [i.strip() for i in string if i.strip()]


def remove_punc(string):
    return re.sub('\W+', '', string)

DELIMITER_LIST = [
    ';',
    '/',
    ',',
    '.',
    ':',
    '|',
    '$',
    '\t',
]


def check_usable_delimiter(table, column_name=None):
    alphabet = set()
    for row in table:
        for column, value in row.items():
            if column_name and column_name != column:
                continue
            if not value:
                continue
            alphabet.update(set(str(value)))

    for delimiter in DELIMITER_LIST:
        if delimiter not in alphabet:
            return delimiter
    return None


def check_certain_columns_have_value(row, only_columns):
    columns = list(row.keys())
    other_columns = list(set(columns) - set(only_columns))
    for c in other_columns:
        if row[c]:
            return False

    for c in only_columns:
        if not row[c]:
            return False

    return True


def remove_dup(table, key):
    result = []
    keys = set()

    for i in table:
        value = i[key]
        if value in keys:
            continue
        keys.add(value)
        result.append(i)

    return result
