import numpy as np
from matplotlib import pyplot as plt
profit={"2019":35,"2020":45,"2021":85}
names=list(profit.keys())
values=list(profit.values())
plt.bar(names,values)
plt.title('Bar Plot')
plt.xlabel('Year')
plt.ylabel("Economy's Capabality")
plt.grid(True)
plt.show()