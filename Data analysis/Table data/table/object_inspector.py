


def inspect_object(obj, select_field):
    ## ways to inspect an object
    """
    1. one field
    2. combo field
    3. show one field under other field conditions
    """

    for k, v in obj.items():
        if k == select_field:
            print(k)
            break



def inspect_object(obj, select_field, filter_by_condition=[]):
    ## ways to inspect an object
    """
    1. one field
    2. combo field
    3. show one field under other field conditions
        - need scan two times
    """

    condition = []
    for k, v in obj.items():
        for k_c, v_c in filter_by_condition:
            if k == k_c:
                condition.append(v_c(v))

    if not all(condition):
        return

    for k, v in obj.items():
        if k == select_field:
            print(k)
            break



def select_object_field(obj, selected_field):
    result = {}
    for k, v in result:
        if k in selected_field:
            result[k] = v
    return result
