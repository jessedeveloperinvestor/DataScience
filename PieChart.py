import numpy as np
from matplotlib import pyplot as plt
bestjobs=['Cyberguard','Computer Engineer','Data Scientist','Well Paid Public Employee','Eletricist']
quantity=[40,30,15,10,5]

plt.pie(quantity,labels=bestjobs,autopct=%0.1f%%
	,colors=['gray','blue','green','red','orange'])
plt.show()