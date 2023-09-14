#Comandos para fazer um gráfico simples de linhas usado na aula 1#
attach(tropas_ONU)
plot(ano, tropas,type = "o", col = "darkblue", xlab = "Anos", ylab = "Tropas",main = "Tropas na ONU por ano")
plot(ano, tropas,type = "o", col = "darkblue", xlab = "Anos", ylab = "Tropas",main = "Tropas na ONU por ano", lwd=10)