#Comandos da Etapa 5 - Estatísticas Descritivas#
attach(guerras)
pais
detach(guerras)
guerras$pais
attach(guerras)
tapply(mortes,pais,sum)
str(guerras)
install.packages("summarytools")
library(summarytools)
freq(pais, cumul = TRUE, totals = FALSE, order = "freq")

install.packages("summarytools")
library(summarytools)

descr(guerras[ ,6:7], style='rmarkdown')

brazil<- subset(guerras, pais == "Brazil")

descr(brazil[ ,6:7], style='rmarkdown')