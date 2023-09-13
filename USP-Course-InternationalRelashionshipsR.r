kkkk#R

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


  unnest_tokens(output = "words", input = texto)
  texto_un

#Obter os l�xicos do dicion�rio AFINN#

AFINN <- get_sentiments("afinn")


# Merge os dados: jun��o por interse��o, juntar texto_un com os lexicos e polaridade do pacote LexiconPT.#

tb_sen <- inner_join(texto_un,
                     AFINN[, c("word", "value")],
                     by = c("words" = "word"))

# Faz a agrega��o pela m�dia do sentimento por discurso das autoridades#

tb <- tb_sen %>%
  group_by(id, sigla, ano) %>%
  summarise(media = mean(value),
            n = n(),
            sentiment = media/n)

# Densidade de kernel do escore de sentimento dos pa�ses#
ggplot(tb, aes(sentiment, colour = sigla)) +
  geom_density() +
  xlim(-0.1, 0.1)+
  labs(x = "Sentimento", y = "Densidade")

#Novo objeto com os anos nos dois pa�ses#

tb2 <- tb_sen %>%
  group_by(pais, ano) %>%
  summarise(media = mean(value),
            n = n(),
            sentiment = media)
        

#Gr�fico desse novo objeto por nome e sentimento#


tb2 %>%
  ggplot( aes(x=ano, y=sentiment, group=pais, color=pais)) +
  geom_line() +
  scale_color_viridis(discrete = TRUE) +
  ggtitle("Sentimento por Pot�ncia e Ano") +
  ylab("Sentimento do Discurso")

# Determina as frequ�ncias dos termos de polaridade n�o nula.

tb_words4 <- tb_sen %>%
  count(words, value, sigla, sort = TRUE) %>%
  filter(value != 0)

#Prepara o objeto para virar nuvem de palavra#

tb_cloud <- tb_words4 %>%
  spread(key = "sigla", value = "n", fill = 0) %>%
  rename("China" = "CHI", "Estados Unidos" = "USA")
tb_cloud

tb3 <- as.data.frame(tb_cloud[, c("China", "Estados Unidos")])
rownames(tb3) <- tb_cloud$words
head(tb3)


comparison.cloud(tb3,
                 colors = c("red", "blue"),
                 max.words = min(nrow(tb), 500))

#An�lise de sentimento com o dicion�rio NRC#

NRC <- get_sentiments("nrc")

discurso_nrc <- inner_join(texto_un,
                     NRC[, c("word", "sentiment")],
                     by = c("words" = "word"))

decade_mood <-  discurso_nrc %>%
  filter(sigla != "NA" & !sentiment %in% c("positive", "negative")) %>%
  count(sentiment, sigla) %>%
  group_by(sigla, sentiment) %>%
  summarise(sentiment_sum = sum(n)) %>%
  ungroup()

my_colors <- c("#E69F00", "#56B4E9", "#009E73", "#CC79A7", "#D55E00")
grid.col = c("China" = my_colors[1], "USA" = my_colors[2], "anger" = "grey", "anticipation" = "grey", "disgust" = "grey", "fear" = "grey", "joy" = "grey", "sadness" = "grey", "surprise" = "grey", "trust" = "grey")

circos.clear()

circos.par(gap.after = c(rep(5, length(unique(decade_mood[[1]])) - 1), 15,
                         rep(5, length(unique(decade_mood[[2]])) - 1), 15))
chordDiagram(decade_mood,grid.col = grid.col, transparency = .2)
title("Sentimentos Mobilizados por China e EUA no CSONU")