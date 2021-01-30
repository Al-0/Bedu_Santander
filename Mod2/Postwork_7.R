## Declaramos la librer�a mongolite para poder comunicarnos con nuestro cluster en Atlas
#install.packages("mongolite")
library(mongolite)

# Declaramos el wd en la carpeta donde tenemos "data.csv" y guardamos la informaci�n en un df
setwd("C:/Users/valen/Documents/Bedu/Mod2/Programacion-con-R-Santander-master/Programacion-con-R-Santander-master/Sesion-07/Postwork_Al")
data <- read.csv("data.csv")
class(data)
head(data)

# Utilizamos la instrucci�n 'mongo' para crear una conexi�n al cluster
# Entramos el nombre de la colecci�n y base de datos para crearlas en el cluster
?mongo
m <- mongo(
  collection = "match",
  db = "match_games",
  url = "mongodb+srv://bedu:1452@cluster0.6x4ut.mongodb.net/test?authSource=admin&replicaSet=atlas-12mrpb-shard-0&connectTimeoutMS=600000&socketTimeoutMS=6000000&readPreference=primary&appname=MongoDB%20Compass&ssl=true"
)
m

# Insertamos la informaci�n anteriormente le�da del csv en la base de datos
m$insert(data)

# Realizamos un count para conocer el n�mero de registros de la base
m$count()

# Se realiza la siguiente consulta para conocer el n�mero de goles que meti� el Real Madrid
# el 20 de diciembre de 2015, as� como el equipo contra el que jug�
full_document <- m$find();
summary(full_document)
query <- m$find('{
  "Date" : "2015-12-20",
  "$or" : [
      {"HomeTeam" : "Real Madrid"},
      {"AwayTeam" : "Real Madrid"}
  ]
}');query
## Como podemos observar, la query no encuentra ning�n resultado,lo cual se debe a que el csv
## proporcionado s�lo contiene los resultados de las temporadas 2017 a 2020. Si existiera el
## registro de la temporada 2015-2016, podr�amos ver que aquella noche decembrina de hace ya
## un lusto el equipo madrile�o le propin� una reverenda goleada de 10-2 al Rayo Vallecano en
## la cancha del monumental estadio Santiago Bernab�u. �Hala Madrid!

# Agregamos una nueva colecci�n a la base de datos, en esta ocasi�n utilizando el df 'mtcars'
summary(mtcars)
mtcars_collection <- mongo(
  collection = "mtcars",
  db = "match_games",
  url = "mongodb+srv://bedu:1452@cluster0.6x4ut.mongodb.net/test?authSource=admin&replicaSet=atlas-12mrpb-shard-0&connectTimeoutMS=600000&socketTimeoutMS=6000000&readPreference=primary&appname=MongoDB%20Compass&ssl=true"
)
mtcars_collection$insert(mtcars)

# Finalmente cerramos las conexiones a la base de datos
rm(m)
rm(mtcars_collection)
gc()