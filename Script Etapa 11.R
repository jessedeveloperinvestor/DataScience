#Mapas Dinâmicos - Empréstimo BNDES e Cooperação Brasileira - Reservas e Produção de Petróleo#

#Instalação de alguns pacotes - nem todos vão ser usados, mas esses pacotes oferecem muita opção para explorar#
install.packages(c("raster", "dplyr", "spData", "spDataLarge", "sf"))
install.packages(c("leaflet", "shiny"))
install.packages("readxl")
install.packages("htmlwidgets")
install.packages("magick")
install.packages("here")
install.packages("tmap")
install.packages("ggplot2")
install.packages("gifski")
#Convocação dos pacotes#
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

#Importa o arquivo mapa com dados do BNDES e Cooperação Brasileira - vamos chamar o objeto de br#

br <- read_excel("C:/Users/Paulo/Documents/Documents/CursoR_Apolo/Bases de dados/mapa.xls", col_types = c("text","text","numeric","numeric"))

#Convoca o mapa mundi#
data("World")

#Ordena pelo nome do país as duas bases#
World <- World[order(World$iso_a3),]
br <- br[order(br$iso_a3),]

#Junta as bases de dados criando o objeto br_2#
br_2 <-merge(World, br)

#Cria o mapa com duas variáveis: loans_2 (empréstimos do BNDES) e "coop_2" (cooperação bilateral do Brasil)#

tm_shape(br_2) +
  tm_polygons("loans_2", style = "fixed",breaks = c(1, 309, 2800, 7127, 15783, 24360, 34811), textNA = "No Loans", colorNA = "white", title = "BNDES Loans(100 thousands R$)") +
  tm_symbols(col = "black",  style="jenks", border.col = "white", size = "coop_2", scale=1.0, title.size = "Bilateral Cooperation(100thousands R$)")+
  tm_layout(legend.outside = TRUE)

#Importa a base reservas em excel que possui a produção e reservas para quatro décadas#
reservas <- read_excel("C:/Users/Paulo/Documents/Documents/CursoR_Apolo/Bases de dados/reservas.xls", col_types = c("numeric","numeric","numeric","numeric","text", "numeric","numeric","numeric","numeric"))

#Checa se os nomes dos países na base em excel e no mapa World são iguai#
identical(World$name,reservas$name)

#Ordena pelo nome do país as duas bases#
World <- World[order(World$name),]
reservas <- reservas[order(reservas$name),]

#Junta as bases de dados criando o objeto map#
map <-merge(World, reservas)

#Salva mapa dinâmico em html#
petro=tm_shape(map) +
  tm_polygons("p_2016", title = "Produção Petróleo") +
  tm_symbols(col = "black", border.col = "white", size = "r_2016", scale=1.2)
tmap_save(tm = petro, filename = "C:/Users/Paulo/Documents/Documents/CursoR_Apolo/petroleo.html", width = 1200, height = 1000)


#Criação de GIF com a evolução da produção e reservas de petroleo por decada (1986-2016)#
#Novo banco de dados denominado reservas_din#
reservas_gif <- read_excel("C:/Users/Paulo/Documents/Documents/CursoR_Apolo/Bases de dados/reservas_din.xls", col_types = c("text", "numeric","numeric","numeric"))

#Mesmos comandos#
identical(World$name,reservas_gif$name)
World <- World[order(World$name),]
reservas_gif <- reservas_gif[order(reservas_gif$name),]
map2 <-merge(World, reservas_gif)

#Cria quatro mapas, um para cada década#
petroleo_gif = tm_shape(map2) + tm_polygons("producao") + tm_dots(size = "reservas") +
  tm_facets(along = "year", free.coords = FALSE, ncol = 1, nrow=1, as.layers = TRUE, free.scales.symbol.size = FALSE)

#Gera o arquivo de animação em gif. Note que é preciso ter um programa instalado para o R fazer a animação: https://imagemagick.org/script/download.php#windows#
tmap_animation(petroleo_gif, filename = "C:/Users/Paulo/Documents/Documents/CursoR_Apolo/petroleo_2.gif", delay = 100, width = 1800, height = 1000)

#Mapa estático com as 4 décadas#
petroleo_decada = tm_shape(map2) + tm_polygons("producao") + tm_dots(size = "reservas") +
  tm_facets(by = "year", free.coords = FALSE, ncol = 2, nrow=2, as.layers = FALSE, free.scales.symbol.size = FALSE)
petroleo_decada
