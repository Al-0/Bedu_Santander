# Se importa la librería rsample para generar el muestreo por bootstrap
library(rsample)
# Se importa tidyverse para poder usar map
library(tidyverse)

# Declaramos nuestro directorio de trabajo, y de este, descargamos el archivo "laLiga.csv",
# el cuál se obtuvo escribiendo en un archivo el data frame resultante del postwork #2.
setwd("C:/Users/valen/Documents/Bedu/Mod2/Programacion-con-R-Santander-master/Programacion-con-R-Santander-master/Sesion-04/Postwork_Al")
laLiga <- read.csv("laLiga.csv")
head(laLiga)
View(laLiga)
table(laLiga$FTAG)

# La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)
home <- round(table(laLiga$FTHG) / nrow(laLiga), 3);home
# La probabilidad (marginal) de que el equipo que juega como visitante anote y goles 
# (y=0,1,2,)
away <- round(table(laLiga$FTAG) / nrow(laLiga), 3);away
# La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo 
# que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
conditional <- round(table(laLiga$FTHG, laLiga$FTAG) / nrow(laLiga), 3);conditional
# Obtenemos la tabla de  cocientes al dividir estas probabilidades conjuntas por el producto
# de las probabilidades marginales correspondientes.
# Usamos la operación outer para obtener el producto exterior de las probabilidades marginales.
home_times_away <- outer(home, away); home_times_away
cocientes <- conditional / home_times_away;cocientes

# Analizamos la frecuencia de obtener ciertos resultados, y en base a esto decidimos eliminar 
# los outliers (Prob < 2%) del análsis por bootstrap
home
away
# Se decide hacer bootstrap con una gráfica de 5x5

# Declaramos una semilla para obtener el mismo muestreo aleatorio
set.seed(2)
# Se obtienen 10000 muestreos de nuestro data frame original
sample_number <- 10000
bt_samples <- bootstraps(laLiga, times = sample_number)

# Se declara en una función el proceso para generar la tabla de cocientes
statistic <- function(splits) {
  x <- analysis(splits)
  bt_home <- round(table(x$FTHG) / nrow(x), 3);
  bt_away <- round(table(x$FTAG) / nrow(x), 3);
  bt_conditional <- round(table(x$FTHG, x$FTAG) / nrow(x), 3)
  bt_home_times_away <- outer(home, away)

  # Realizamos por medio de un for la tabla de cocientes para garantizar que siempre
  # tenga las mismas dimensiones, sin importar que outliers no se incluyan en el
  # muestreo de bootstrap
  bt_home <- as.matrix(bt_home)
  bt_away <- as.matrix(bt_away)
  bt_cocientes <- matrix(0,5,5)
  for(i in 1:5) {
    for(j in 1:5) {
      bt_cocientes[i, j] <- bt_conditional[i, j] / (bt_home[i] * bt_away[j])
    }
  }
  
  bt_cocientes
}

# Se obtienen 10000 tablas de cocientes apartir de los datos de bootstrap
bt_cocientes <- map(bt_samples$splits, statistic)
head(bt_cocientes)
summary(bt_cocientes)

# La siguientes lineas generan histogramas por cada una de las celdas de la tabla de cocientes.
# Analizando el valor de la media y la distribución de estas gráficas concluimos que los siguientes
# valores se aproximan a 1 (algunos valores podrían ser añadidos o removidos, esto a discreción del
# analista):
## H ~ A
## 0   0
## 0   1
## 0   2
## 1   0
## 1   1
## 1   2
## 1   3
## 1   4
## 2   0
## 2   1
## 2   2
## 3   2
## 3   3
## 4   2
#bt_cuantiles <- data.frame(matrix(0,0,6))
par(mfrow=c(5,5))
for (i in 1:5){
  for (j in 1:5){
    values <- vector()
    for (k in 1:sample_number){
      values[k] <- bt_cocientes[[k]][i,j]
    }
    #bt_cuantiles <- rbind(bt_cuantiles,c(i-1,j-1,quantile(values, probs = c(.05, .5, .95)),mean(values)))
    hist(values, 
         main = paste("Media de cocientes. ","H: ",i-1,". A: ",j-1, "."),
         xlab = "Cociente",
         ylab = "Frecuencia")
    abline(v = 1, col = "red")
    abline(v = mean(values), col="blue")
  }
}
#names(bt_cuantiles) <- c('Goles local','Goles visita','0.05%','Mediana (50%)','0.95','Promedio')
#tail(bt_cuantiles)

# Analizando los intervalos de confianza del muestreo, solamente fue posible descartar el siguiente
# resultado:
## H ~ A
## 4   3
par(mfrow=c(5,5))
for (i in 1:5){
  for (j in 1:5){
    values <- vector()
    for (k in 1:sample_number){
      values[k] <- bt_cocientes[[k]][i,j]
    }
    hist(values, 
         main = paste("Int.confianza. ","H:",i-1,". A: ",j-1),
         xlab = "Cociente",
         ylab = "Frecuencia")
    abline(v = 1, col = "red")
    abline(v = c(quantile(values, c(0.025,0.975))), col = "green")
  }
}
