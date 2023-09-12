#R

2+2 #soma#
8*2 #multiplicação#
10/2 #divisão#
12-2 #subtração#
3^2 #exponencial#
(((7.5*4)+(4*6))/10)^2 #expressão com mais de uma conta# 


sqrt(10) # tira a raiz quadrada dos argumentos entre parênteses
prod(2,2,3,4) # realiza um produto 2x2x3x4
abs(17-50) # módulo
factorial(6) # 6 fatorial (6!)


notas<-c(2.5, 10, 7, 9.5, 5, 3.5, 6.4, 10, 8.5)
notas
length(notas)
notas[6] # retorna a sexta nota do vetor
notas[c(2,7,9)] # acessa o segundo, sétimo e nono valores
max(notas) # valor máximo contido no objeto notas
min(notas) # nota mínima
sum(notas) # Soma dos valores de notas
sqrt(notas) # Retorna a raiz quadrada dos valores
sort(notas) # organiza em ordem crescente
sort(notas, decreasing=TRUE) # organiza em ordem decrescente
sample(notas, size=2, replace=FALSE)


#Comando para buscar músicas#
install.packages("chorrrds")
library(chorrrds)
install.packages("tidyverse")
library(tidyverse)
mutantes <- "mutantes" %>% chorrrds::get_songs() %>% dplyr::sample_n(10)
beyonce <- "beyonce" %>% chorrrds::get_songs() %>% dplyr::sample_n(10)
TomJobim <- "tom-jobim" %>% chorrrds::get_songs() %>%
dplyr::sample_n(10)
mutantes
beyonce
TomJobim


#Comandos da Etapa 5 - Estatasticas Descritivas#
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


#mportar o banco de dados cinc#
#Trocar o nome da vari�vel cinc por poder#
fix(cinc)
attach(cinc)
t<-tapply(poder,csonu,sum)
porc<-round(t,2)
rotulos<-paste("(",porc,"%)",sep="")
pie(t, main="Gr�fico Etapa 6 - Poder no CSONU",labels=rotulos, col=rainbow(2), sub="Fonte: COW (2021)", cex.main=1.0, cex.sub=0.5, col.main="darkblue", radius=1.0)
legend(locator(1),legend=rownames(t), fill=c(rainbow(2)),bty="n", cex = 0.8, pt.cex = 1:2, text.font=2)


#Comandos para fazer um gr�fico simples de linhas usado na aula 1#
attach(tropas_ONU)
plot(ano, tropas,type = "o", col = "darkblue", xlab = "Anos", ylab = "Tropas",main = "Tropas na ONU por ano")
plot(ano, tropas,type = "o", col = "darkblue", xlab = "Anos", ylab = "Tropas",main = "Tropas na ONU por ano", lwd=10)


install.packages("ggplot2")
library(ggplot2)

ggplot(vetos_CSONU, aes(fill=anos, y=pais, x=vetos)) + geom_bar(position="stack", stat="identity")+ 
  labs(title = "Vetos das Pot�ncias no CSONU ",
       subtitle = "Fonte: Dyson (2013)",
       x = "N�mero de Vetos",
       y = "Pot�ncias Poder de Veto")


install.packages("foreign")
install.packages ("ggplot2")
install.packages ("ggmap")
install.packages ("reshape2")
install.packages ("maps")
install.packages ("Cairo")

library(foreign)
library(ggplot2)
library(ggmap)
library(reshape2)
library(maps)
library(Cairo)
attach(economia)
econ <- subset(economia, select=c(country, income_tax_rate))
world  = map_data("world")   
world1 <- merge (world, econ, by.x="region", by.y="country", all.x=T, all.y=F) 
world1 <- world1[order(world1$order),] 
m0 <- ggplot(data=world1)
m1 <- m0 + geom_polygon(aes(x=long, y=lat, group=group, fill= income_tax_rate)) + coord_equal()
m2 <- m1 + geom_path(aes(x=long, y=lat, group=group), color='grey', size=.1)
m3 <- m2 + scale_fill_gradient(low = "lightblue", high = "darkblue")
m3
