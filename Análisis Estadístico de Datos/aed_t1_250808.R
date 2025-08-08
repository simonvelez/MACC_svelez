# AED Taller 1
# 2025-08-08
# Simón Vélez

library(dplyr)

# Cargar la base de datos

screen <- read.csv("~/Documents/GitHub/MACC_svelez/Análisis Estadístico de Datos/bases_datos/screen.csv")

screen_cuant <- screen %>% select(Age, Avg_Daily_Screen_Time_hr, Educational_to_Recreational_Ratio)
  
S = cov(screen_cuant); S

# a) Calcule la varianza generalizada

VG = det(S); VG

# b) Calcule la varianza total e indique cu´al variable aporta m´as.

VT = sum(diag(S)); VT

# c) Calcule la distancia de Mahalanobis y al distancia euclidiana para el individuo 2, ¿Qu´e observa?
# d ) Construya la matriz de correlaci´on a partir de la matriz de varianzas y covarianzas.


# Gráfica del punto 1C

library(Epi)
library(dplyr)
library(skimr)
library(ggplot2)
library(GGally)
library(plotly)
library(moments)


screen2 = screen %>% select(Avg_Daily_Screen_Time_hr, Educational_to_Recreational_Ratio, Gender)
  ggpairs(screen2, aes(color = Gender))


graf1 = ggplot(screen, 
               aes(x = Health_Impacts,
                   y = Avg_Daily_Screen_Time_hr,
                   fill=Health_Impacts))+
geom_boxplot();graf1
