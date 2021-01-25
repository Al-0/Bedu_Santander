# Cargamos la libreria ggplot para graficar, dplyr para modificar dataframes.
library(ggplot2)
library(dplyr)

# Declaramos nuestro directorio de trabajo, y de este, descargamos el archivo "laLiga.csv",
# el cuál se obtuvo escribiendo en un archivo el data frame resultante del postwork anterior.
setwd("C:/Users/valen/Documents/Bedu/Mod2/Programacion-con-R-Santander-master/Programacion-con-R-Santander-master/Sesion-03/Postwork_Al")
laLiga <- read.csv("laLiga.csv")
head(laliga)
view(laLiga)


## 1.Con el último data frame obtenido en el postwork de la sesión 2, elabora tablas de 
## frecuencias relativas para estimar las siguientes probabilidades:
# La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)
home <- round(table(laLiga$FTHG) / nrow(laLiga), 4);home
# La probabilidad (marginal) de que el equipo que juega como visitante anote y goles 
# (y=0,1,2,)
away <- round(table(laLiga$FTAG) / nrow(laLiga), 4);away
# La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo 
# que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
conditional <- round(table(laLiga$FTHG, laLiga$FTAG) / nrow(laLiga), 4);conditional


## 2. Realiza lo siguiente:
# Un gráfico de barras para las probabilidades marginales estimadas del número de goles 
# que anota el equipo de casa
home <- as.data.frame(home)  
head(home)
home <- home %>% mutate(Goles = Var1, Probabilidad_marginal = Freq) %>% 
  select(Goles, Probabilidad_marginal);
home
home %>% ggplot() + aes(x = Goles, y = Probabilidad_marginal) + 
  geom_col(color = 'black', fill = "white") +
  ggtitle("Probabilidad de marcar gol como local. La Liga, 17-20") +
  theme_dark()
# Un gráfico de barras para las probabilidades marginales estimadas del número de goles 
# que anota el equipo visitante.
away <- as.data.frame(away)  
head(away)
away <- away %>% mutate(Goles = Var1, Probabilidad_marginal = Freq) %>% 
  select(Goles, Probabilidad_marginal);
away
away %>% ggplot() + aes(x = Goles, y = Probabilidad_marginal) + 
  geom_col(color = 'white', fill = "black") +
  ggtitle("Probabilidad de marcar gol como visitante. La Liga, 17-20") +
  theme_light()
# Un HeatMap para las probabilidades conjuntas estimadas de los números de goles que 
# anotan el equipo de casa y el equipo visitante en un partido.
conditional <- as.data.frame(conditional);conditional
conditional <- conditional %>% rename(Local = Var1, Visita = Var2, Probabilidad_marginal = Freq)
head(conditional)
conditional %>% ggplot() + 
  aes(x = Local, y = Visita, fill = Probabilidad_marginal) +
  geom_tile(color = "black") +
  ggtitle("Probabilidad conjunta de goles. La Liga, 17-20") +
  scale_fill_gradient2(low = "darkgreen", mid = "white", high = "darkred") +
  xlab("Goles del Local") +
  ylab("Goles del Vistante")
