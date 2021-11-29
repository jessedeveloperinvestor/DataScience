#pip install yfinance
import yfinance as yf
import pandas as pd
import numpy as np
assets=['B3SA3','USDBRL=X','SAPR4','ETH-USD']
startr='2021-01-01'
endr='2021-11-29'
prices=pd.DataFrame()
for i in assets:
	prices[i]=yf.download(i, start=startr, end=endr)['Adj Close']
	prices['ETH-BRL']=prtices['ETH-USD']*prices['USDBRL=X']
	prices=prices.drop(columns=['ETH-USD','USDBRL=X'])