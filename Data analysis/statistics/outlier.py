from math import log10


def power_quantity(value, base):
    if not value or not base:
        return 0
    return log10(value / base)
