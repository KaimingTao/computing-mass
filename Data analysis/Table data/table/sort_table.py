from operator import itemgetter


def sort_by(table, column_name_list):
    if type(column_name_list) != list:
        column_name_list = [column_name_list]
    # TODO: column force to same data type
    return sorted(table, key=itemgetter(*column_name_list))


def check_column_type():
    pass

def set_column_type(table, column_name, type):
    pass
