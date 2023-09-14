#Comandos Etapa 12 - Teste Qui quadrado#

library(readxl)

venezuela<-read_xls("C:/Users/Paulo/Documents/Documents/CursoR_Apolo/Bases de dados/Entrada_Venezuela_CN.xls")

venezuela$Ideologia <- factor(venezuela$Ideologia,
                    levels = c(0,1),
                    labels = c("Direita", "Esquerda"))

venezuela$Coalizão <- factor(venezuela$Coalizão,
                              levels = c(0,1),
                              labels = c("Oposição", "Governo"))

venezuela$Voto <- factor(venezuela$Voto,
                             levels = c(0,1),
                             labels = c("Não", "Sim"))


attach(venezuela)

t1 = table(Voto,Ideologia)
barplot(t1, beside=TRUE, legend=TRUE, ylim=c(0,200),main="Gráfico 1. Aprovação Entrada da Venezuela no MERCOSUL por Ideologia")


chisq.test(t1)


t2 = table(Voto,Coalizão)
barplot(t2, beside=TRUE, legend=TRUE, ylim=c(0,300) , args.legend = list(bty = "n", x = "top", cex=2.0, ncol = 2), main="Gráfico 2. Aprovação Entrada da Venezuela no MERCOSUL por Coalizão")

chisq.test(t2)





