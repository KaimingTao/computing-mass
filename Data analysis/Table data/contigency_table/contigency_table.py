
def calc_contigency_table(listA, listB):

    match_list = list(zip(listA, listB))

    tt = [
        1
        for i, j in match_list
        if i and j
    ]

    tf = [
        1
        for i, j in match_list
        if i and not j
    ]

    ft = [
        1
        for i, j in match_list
        if not i and j
    ]

    ff = [
        1
        for i, j in match_list
        if not i and not j
    ]

    return {
        'TT': len(tt),
        'TF': len(tf),
        'FT': len(ft),
        'FF': len(ff),
        'total': len(match_list)
    }


def calc_recall_precision_F1(cont_table):

    recall = cont_table['TT'] / (
        cont_table['TT'] + cont_table['TF'])
    precision = cont_table['TT'] / (
        cont_table['TT'] + cont_table['FT'])
    f1_score = 2 * precision * recall / (precision + recall)

    return recall, precision, f1_score
