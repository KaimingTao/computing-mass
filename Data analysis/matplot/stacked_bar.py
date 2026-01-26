# simple stacked bar

import matplotlib.pyplot as plt
import numpy as np

x = np.arange(3)
a = [3, 2, 4]
b = [1, 3, 2]

plt.bar(x, a, label="A")
plt.bar(x, b, bottom=a, label="B")  # stacked on top of A

plt.legend()
plt.show()


## stacked bar by pandas
# the table should have a index, column name will be category
df.plot(kind='bar', stacked=True, ax=ax)
