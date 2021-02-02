# Tidyverse para usar dplyr, lubridate para extraer año y mes
library(tidyverse)
library(lubridate)

# Declaramos nuestro directorio, leemos y guardamos el csv
setwd("C:/Users/valen/Documents/Bedu/Mod2/Programacion-con-R-Santander-master/Programacion-con-R-Santander-master/Sesion-06/Postwork_Al")
data <- read.csv("match.data.csv")
head(data)

# 1.- Agrega una nueva columna sumagoles que contenga la suma de goles por partido.
data <- data %>% mutate(sumagoles = home.score + away.score)
head(data)
dim(data)

# 2.- Obtén el promedio por mes de la suma de goles.
data <- data %>% 
  mutate(mes_y_año = format(as.Date(data$date), "%Y-%m"));head(data)
goles_por_mes <- data %>% group_by(mes_y_año) %>% 
  summarize(goles_mensuales = mean(sumagoles))
head(goles_por_mes)

# 3.-Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre 
# de 2019.
tail(goles_por_mes)
View(goles_por_mes)
# Se puede observar que el tibble obtenido tiene una frecuencia de 10 meses por año, ya
# que las temporadas empiezan en agosto de un año y terminan en mayo del año siguiente. 
# La excepción es la temporada 2012-2013, la cual termino el primero de Junio y presenta
# un problema para la frecuencia de la serie de tiempo.
# https://es.wikipedia.org/wiki/Primera_Divisi%C3%B3n_de_Espa%C3%B1a_2012-13
# Puesto que esta fecha sólo representa 1 jornada de juegos, su promedio es un outlier
goles_por_mes %>% filter(mes_y_año == "2013-06")
# Se prosigue a remover este dato para mantener la frecuencia de la serie de tiempo
# Nota: El inicio de la temporada 2015-2016 tambien presenta el problema de pocas 
# jornadas y un valor outlier, pero como no afecta la frecuencia, no se remueve.
goles_por_mes <- goles_por_mes %>% filter(mes_y_año != "2013-06")
?ts
goles.ts <- ts(goles_por_mes$goles_mensuales, start = c(2010,5), end = c(2019,9), frequency = 10)
goles.ts
head(goles_por_mes)
tail(goles_por_mes, n = 10)

# 4.- Grafica la serie de tiempo
plot(goles.ts,
     xlab = "Año",
     ylab = "Promedio de goles",
     main = "Goles a lo largo de los años. La Liga 2010-2019")
