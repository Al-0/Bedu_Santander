## Declaramos la librería mongolite para poder comunicarnos con nuestro cluster en Atlas
#install.packages("mongolite")
library(mongolite)

# Declaramos el wd en la carpeta donde tenemos "data.csv" y guardamos la información en un df
setwd("C:/Users/valen/Documents/Bedu/Mod2/Programacion-con-R-Santander-master/Programacion-con-R-Santander-master/Sesion-07/Postwork_Al")
data <- read.csv("data.csv")
class(data)
head(data)

# Utilizamos la instrucción 'mongo' para crear una conexión al cluster
# Entramos el nombre de la colección y base de datos para crearlas en el cluster
?mongo
m <- mongo(
  collection = "match",
  db = "match_games",
  url = "mongodb+srv://bedu:1452@cluster0.6x4ut.mongodb.net/test?authSource=admin&replicaSet=atlas-12mrpb-shard-0&connectTimeoutMS=600000&socketTimeoutMS=6000000&readPreference=primary&appname=MongoDB%20Compass&ssl=true"
)
m

# Insertamos la información anteriormente leída del csv en la base de datos
m$insert(data)

# Realizamos un count para conocer el número de registros de la base
m$count()

# Se realiza la siguiente consulta para conocer el número de goles que metió el Real Madrid
# el 20 de diciembre de 2015, así como el equipo contra el que jugó
full_document <- m$find();
summary(full_document)
query <- m$find('{
  "Date" : "2015-12-20",
  "$or" : [
      {"HomeTeam" : "Real Madrid"},
      {"AwayTeam" : "Real Madrid"}
  ]
}');query
## Como podemos observar, la query no encuentra ningún resultado,lo cual se debe a que el csv
## proporcionado sólo contiene los resultados de las temporadas 2017 a 2020. Si existiera el
## registro de la temporada 2015-2016, podríamos ver que aquella noche decembrina de hace ya
## un lusto el equipo madrileño le propinó una reverenda goleada de 10-2 al Rayo Vallecano en
## la cancha del monumental estadio Santiago Bernabéu. ¡Hala Madrid!

### Corrección al 03 de Febrero de 2021
# Obtenemos la información de la temporada 2015-2016
url <- "https://www.football-data.co.uk/mmz4281/1516/SP1.csv"
data2 <- read.csv(url)
head(data2)
data2 <- data2 %>% select(Date:FTR) %>% mutate(Date = as.Date(Date, "%d/%m/%y"));head(data2)
# Cargamos esta información a la base de datos
m$insert(data2)
m$count()
# Ahora realizamos nuevamente la consulta anterior
query <- m$find('{
  "Date" : "2015-12-20",
  "$or" : [
      {"HomeTeam" : "Real Madrid"},
      {"AwayTeam" : "Real Madrid"}
  ]
}');query
# Como podemos observar, vemos confirmada esa goleada bárbara anteriormente descrita.

# Agregamos una nueva colección a la base de datos, en esta ocasión utilizando el df 'mtcars'
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
