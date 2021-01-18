# Utilizamos la libreria tidyverse para utilizar dplyr
library(tidyverse)

# Necesitamos descargar el archivo csv con la información, por lo que 
# declaramos nuestro directorio, descargamos y leemos el archivo
# setwd("C:/Users/valen/Documents/Bedu/Mod2/Programacion-con-R-Santander-master/Programacion-con-R-Santander-master/Sesion-01/Postwork_Al")
url = "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
download.file(url, "laliga1920.csv")
esp19_20 <- read.csv("laliga1920.csv")

# Examinamos el archivo y obtenemos las columnas de relevancia
head(esp19_20)
str(esp19_20)
info <- esp19_20 %>% select(FTHG:FTAG)
head(info)

# Utilizamos la ayuda provista por R para saber como utilizar la función table
?table
infoTable <- table(info); infoTable

# utilizando esta función obtenemos las probabilidades solicitadas
### La probabilidad marginal es la probabilidad de que un evento ocurra sin importar el resultado de otra variable.
### La probabilidad condicional es la probabilidad de que un evento ocurra en presencia de un segundo evento.

## La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...)
golesLocal <- apply(infoTable,1,sum);golesLocal
probGolesLocal <- sapply(golesLocal,function(x){
  round((x / sum(golesLocal)) * 100,2)
});probGolesLocal 

## La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...)
golesVisita <- apply(infoTable,2,sum);golesVisita
probGolesVisita <- sapply(golesVisita,function(x){
  round((x / sum(golesVisita)) * 100,2)
});probGolesVisita

## La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...)
round((infoTable / sum(infoTable) * 100), 2)
