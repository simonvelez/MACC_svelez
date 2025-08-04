# AED práctica Agosto 4 2025
# Distancias

library(dplyr)
library(skimr)
library(ggplot2)
library(GGally)
library(plotly)
library(moments)
library(readxl)

ejemplo1 <- read_excel("Documents/GitHub/MACC_svelez/Análisis Estadístico de Datos/ejemplo1.xlsx", 
                       +     col_types = c("numeric", "numeric", "numeric", 
                                           +         "numeric"))

# Distancia Mahalanobis
DM = mahalanobis(ejemplo1, vector.medias, S); DM

# Distancia euclidiana
matriz.identidad = diag(1,ncol(ejemplo 1))
matriz.identidad

DE = mahalanobis(ejemplo1, vector.medias, matriz.identidad); DE

cbind(DM, DE)