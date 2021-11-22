import numpy as np
from matplotlib import pyplot as plt
x=np.arange(1,11)
print(x)
y1=2*x
y2=3*x
print(y)
plt.plot(x,y1,color='g',linestyle=':',linewidth=2)
plt.plot(x,y2,color='r',linestyle='-.',linewidth=3)
plt.title("Line Plot")
plt.xlabel("x-label")
plt.ylabel("y-label")
plt.grid(True)
plt.show()