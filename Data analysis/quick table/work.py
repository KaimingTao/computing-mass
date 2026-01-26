

class Table:

    def __init__(self, table):
        self.table = table

    def n_rows(self):
        return len(self.table)

    def add_index(self):
        self.table = [
            r.update({
                'index': idx + 1
            })
            for idx, r in enumerate(self.table)]

    def sort(self, **kwargs):
        pass

    def filter(self, **kwargs):
        return Table(self.table)

    def to_csv(self, index=False):
        """
            index=False, because index is not very commonly used
        """
        pass

    def to_excel(self, index=False):
        pass
