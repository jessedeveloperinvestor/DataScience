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


#Mapas Din�micos - Empr�stimo BNDES e Coopera��o Brasileira - Reservas e Produ��o de Petr�leo#

#Instala��o de alguns pacotes - nem todos v�o ser usados, mas esses pacotes oferecem muita op��o para explorar#
install.packages(c("raster", "dplyr", "spData", "spDataLarge", "sf"))
install.packages(c("leaflet", "shiny"))
install.packages("readxl")
install.packages("htmlwidgets")
install.packages("magick")
install.packages("here")
install.packages("tmap")
install.packages("ggplot2")
install.packages("gifski")
#Convoca��o dos pacotes#
library(dplyr)
library(spData)
library(spDataLarge)
library(tmap)
library(readxl)
library(htmlwidgets)
library(magick)
library(here)
library(leaflet) 
library(ggplot2) 
library(shiny)   
library(sf)
library(raster)
library(gifski)

#Importa o arquivo mapa com dados do BNDES e Coopera��o Brasileira - vamos chamar o objeto de br#

br <- read_excel("C:/Users/Paulo/Documents/Documents/CursoR_Apolo/Bases de dados/mapa.xls", col_types = c("text","text","numeric","numeric"))

#Convoca o mapa mundi#
data("World")

#Ordena pelo nome do pa�s as duas bases#
World <- World[order(World$iso_a3),]
br <- br[order(br$iso_a3),]

#Junta as bases de dados criando o objeto br_2#
br_2 <-merge(World, br)

#Cria o mapa com duas vari�veis: loans_2 (empr�stimos do BNDES) e "coop_2" (coopera��o bilateral do Brasil)#

tm_shape(br_2) +
  tm_polygons("loans_2", style = "fixed",breaks = c(1, 309, 2800, 7127, 15783, 24360, 34811), textNA = "No Loans", colorNA = "white", title = "BNDES Loans(100 thousands R$)") +
  tm_symbols(col = "black",  style="jenks", border.col = "white", size = "coop_2", scale=1.0, title.size = "Bilateral Cooperation(100thousands R$)")+
  tm_layout(legend.outside = TRUE)

#Importa a base reservas em excel que possui a produ��o e reservas para quatro d�cadas#
reservas <- read_excel("C:/Users/Paulo/Documents/Documents/CursoR_Apolo/Bases de dados/reservas.xls", col_types = c("numeric","numeric","numeric","numeric","text", "numeric","numeric","numeric","numeric"))

#Checa se os nomes dos pa�ses na base em excel e no mapa World s�o iguai#
identical(World$name,reservas$name)

#Ordena pelo nome do pa�s as duas bases#
World <- World[order(World$name),]
reservas <- reservas[order(reservas$name),]

#Junta as bases de dados criando o objeto map#
map <-merge(World, reservas)

#Salva mapa din�mico em html#
petro=tm_shape(map) +
  tm_polygons("p_2016", title = "Produ��o Petr�leo") +
  tm_symbols(col = "black", border.col = "white", size = "r_2016", scale=1.2)
tmap_save(tm = petro, filename = "C:/Users/Paulo/Documents/Documents/CursoR_Apolo/petroleo.html", width = 1200, height = 1000)


#Cria��o de GIF com a evolu��o da produ��o e reservas de petroleo por decada (1986-2016)#
#Novo banco de dados denominado reservas_din#
reservas_gif <- read_excel("C:/Users/Paulo/Documents/Documents/CursoR_Apolo/Bases de dados/reservas_din.xls", col_types = c("text", "numeric","numeric","numeric"))

#Mesmos comandos#
identical(World$name,reservas_gif$name)
World <- World[order(World$name),]
reservas_gif <- reservas_gif[order(reservas_gif$name),]
map2 <-merge(World, reservas_gif)

#Cria quatro mapas, um para cada d�cada#
petroleo_gif = tm_shape(map2) + tm_polygons("producao") + tm_dots(size = "reservas") +
  tm_facets(along = "year", free.coords = FALSE, ncol = 1, nrow=1, as.layers = TRUE, free.scales.symbol.size = FALSE)

#Gera o arquivo de anima��o em gif. Note que � preciso ter um programa instalado para o R fazer a anima��o: https://imagemagick.org/script/download.php#windows#
tmap_animation(petroleo_gif, filename = "C:/Users/Paulo/Documents/Documents/CursoR_Apolo/petroleo_2.gif", delay = 100, width = 1800, height = 1000)

#Mapa est�tico com as 4 d�cadas#
petroleo_decada = tm_shape(map2) + tm_polygons("producao") + tm_dots(size = "reservas") +
  tm_facets(by = "year", free.coords = FALSE, ncol = 2, nrow=2, as.layers = FALSE, free.scales.symbol.size = FALSE)
petroleo_decada


#Comandos Etapa 12 - Teste Qui quadrado#

library(readxl)

venezuela<-read_xls("C:/Users/Paulo/Documents/Documents/CursoR_Apolo/Bases de dados/Entrada_Venezuela_CN.xls")

venezuela$Ideologia <- factor(venezuela$Ideologia,
                    levels = c(0,1),
                    labels = c("Direita", "Esquerda"))

venezuela$Coaliz�o <- factor(venezuela$Coaliz�o,
                              levels = c(0,1),
                              labels = c("Oposi��o", "Governo"))

venezuela$Voto <- factor(venezuela$Voto,
                             levels = c(0,1),
                             labels = c("N�o", "Sim"))


attach(venezuela)

t1 = table(Voto,Ideologia)
barplot(t1, beside=TRUE, legend=TRUE, ylim=c(0,200),main="Gr�fico 1. Aprova��o Entrada da Venezuela no MERCOSUL por Ideologia")


chisq.test(t1)


t2 = table(Voto,Coaliz�o)
barplot(t2, beside=TRUE, legend=TRUE, ylim=c(0,300) , args.legend = list(bty = "n", x = "top", cex=2.0, ncol = 2), main="Gr�fico 2. Aprova��o Entrada da Venezuela no MERCOSUL por Coaliz�o")

chisq.test(t2)




