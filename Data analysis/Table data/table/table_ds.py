def get_column_values(table, column_name):
    pass

def get_key2records(table, column_name):
    pass

def get_uniq_records(table):
    pass

## Diff table
# 1. simple diff
# 2. sorted then diff
def diff_table(table1, table2):
    pass


# order by preference
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


#Table-wise
def check_usable_spliter(table):
    alphabet = set()
    for row in table:
        for column, value in row.items():
            if not value:
                continue
            alphabet.update(set(str(value)))

    for spliter in SPLITER_LIST:
        if spliter not in alphabet:
            return spliter
    return None


