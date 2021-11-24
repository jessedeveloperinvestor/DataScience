import numpy as np
from matplotlib import pyplot as plt
iris=pd.read_csv('iris.csv')
iris.head()
plt.hist(iris['Sepal.Length'],bins=30,color='r')
plt.show()