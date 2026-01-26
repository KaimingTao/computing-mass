class Table:

    def __init__(self, records):
        self.header = records[0].keys()
        self.records = records

    def __iter__(self):
        for rec in self.records:
            yield rec
