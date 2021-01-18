# Importamos la libreria tidyverse para utilizar las funciones de dplyr
library(tidyverse)

# Vamos a descargar múltiples archivos csv, por lo que configuramos nuestro directorio, descargamos
# y leemos los archivos
# setwd("C:/Users/valen/Documents/Bedu/Mod2/Programacion-con-R-Santander-master/Programacion-con-R-Santander-master/Sesion-02/Postwork_Al")
url1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
download.file(url1,"laliga1718.csv")
download.file(url2,"laliga1819.csv")
download.file(url3,"laliga1920.csv")
laliga.1718 <- read.csv("laliga1718.csv")
laliga.1819 <- read.csv("laliga1819.csv")
laliga.1920 <- read.csv("laliga1920.csv")

# Examinamos los archivos descargados para analizar su estructura
## La Liga 2017-2018 (Visca Barca) 
head(laliga.1718)
str(laliga.1718)
summary(laliga.1718)
View(laliga.1718)
## La Liga 2018-2019 (Visca Barca)
head(laliga.1819)
str(laliga.1819)
summary(laliga.1819)
View(laliga.1819)
## La Liga 2019-2020 (Hala Madrid)
head(laliga.1920)
str(laliga.1920)
summary(laliga.1920)
View(laliga.1920)

# Seleccionamos las columnas Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR de cada uno de los data frames
laliga.1718 <- laliga.1718 %>% select(Date:FTR); head(laliga.1718)
laliga.1819 <- laliga.1819 %>% select(Date:FTR); head(laliga.1819)
laliga.1920 <- laliga.1920 %>% select(Date, HomeTeam:FTR); head(laliga.1920)

# Observamos detalladamente los tipos de las columnas restantes en los data frames
str(laliga.1718)
str(laliga.1819)
str(laliga.1920)
class(laliga.1718$Date)
class(laliga.1819$Date)
class(laliga.1920$Date)

# Podemos observar que los datos de cada df son iguales, sin embargo el formato de las fechas del df
# de la temporada 2017-2018 es distinto. Se procede entonces a cambiar el formato de esta fecha, asi
# como convertir en tipo fecha en los otros 2 df (originalmente siendo tipo factor).
?as.Date
laliga.1718 <- laliga.1718 %>% mutate(Date = as.Date(Date,"%d/%m/%Y"));head(laliga.1718)
laliga.1819 <- laliga.1819 %>% mutate(Date = as.Date(Date,"%d/%m/%Y"));head(laliga.1819)
laliga.1920 <- laliga.1920 %>% mutate(Date = as.Date(Date,"%d/%m/%Y"));head(laliga.1920)
str(laliga.1718);str(laliga.1819);str(laliga.1920)

# Una vez estandarizados nuestros df, procedemos a unirlos en uno solo
laliga <- do.call(rbind,list(laliga.1718, laliga.1819, laliga.1920))
dim(laliga)
str(laliga)
view(laliga)