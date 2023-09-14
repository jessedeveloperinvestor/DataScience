#USP R

install.packages("readxl")
library(readxl)

attach(guerras)
plot(anos, mortes,type = "o", col = "darkblue", xlab = "Anos de Duracao da Guerra", ylab = "Mortes",main = "Mortes em guerras por duracao", lwd=2)
