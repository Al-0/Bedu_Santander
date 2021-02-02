# Declaramos la librería fbRanks para utilizarla más adelante en el script
#install.packages("fbRanks")
library(fbRanks)
# Declaramos tidyverse para usar select y rename
library(tidyverse)

# Declaramos el wd e importamos el csv de La Liga utilizado en postworks anteriores.
setwd("C:/Users/valen/Documents/Bedu/Mod2/Programacion-con-R-Santander-master/Programacion-con-R-Santander-master/Sesion-05/Postwork_Al")
laliga <- read.csv("laLiga.csv")

# 1.- A partir del conjunto de datos de soccer de la liga española de las 
# temporadas 2017/2018, 2018/2019 y 2019/2020, crea el data frame SmallData, 
# que contenga las columnas date, home.team, home.score, away.team y away.score; 
# esto lo puede hacer con ayuda de la función select del paquete dplyr. Luego 
# establece un directorio de trabajo y con ayuda de la función write.csv guarda el 
# data frame como un archivo csv con nombre soccer.csv. Puedes colocar como argumento 
# row.names = FALSE en write.csv.
head(laLiga)
SmallData <- laLiga %>% select(Date, HomeTeam, FTHG, AwayTeam, FTAG) %>%
  rename(date = 'Date', home.team = 'HomeTeam', home.score = 'FTHG', away.team = 'AwayTeam', away.score = 'FTAG')
head(SmallData)
write.csv(smallData,"soccer.csv", row.names = FALSE)

# 2.- Con la función create.fbRanks.dataframes del paquete fbRanks importe el archivo 
# soccer.csv a R y al mismo tiempo asignelo a una variable llamada listasoccer. Se 
# creará una lista con los elementos scores y teams que son data frames listos para la 
# función rank.teams. Asigna estos data frames a variables llamadas anotaciones y equipos.
listasoccer <- create.fbRanks.dataframes("soccer.csv")
head(listasoccer)
anotaciones <- listasoccer$scores
equipos <- listasoccer$teams

# 3.- Con ayuda de la función unique crea un vector de fechas (fecha) que no se repitan y
# que correspondan a las fechas en las que se jugaron partidos. Crea una variable llamada 
# n que contenga el número de fechas diferentes. Posteriormente, con la función rank.teams 
# y usando como argumentos los data frames anotaciones y equipos, crea un ranking de equipos
# usando unicamente datos desde la fecha inicial y hasta la penúltima fecha en la que se 
# jugaron partidos, estas fechas las deberá especificar en max.date y min.date. Guarda los 
# resultados con el nombre ranking.
fecha <- unique(anotaciones$date)
n <- length(fecha)
?rank.teams
primera_fecha <- fecha[which.min(fecha)]; primera_fecha
penultima_fecha <- fecha[which.max(fecha)-1];penultima_fecha
ranking <- rank.teams(scores = anotaciones, teams = equipos, max.date = penultima_fecha, min.date = primera_fecha)
ranking

# 4.- Finalmente estima las probabilidades de los eventos, el equipo de casa gana, 
# el equipo visitante gana o el resultado es un empate para los partidos que se jugaron 
# en la última fecha del vector de fechas fecha. Esto lo puedes hacer con ayuda de la 
# función predict y usando como argumentos ranking y fecha[n] que deberá especificar 
# en date.
?predict
predict(ranking, date = fecha[n])

