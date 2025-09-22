# Regresión con variable cualitativas

library(readr)
insurance <- read_csv("Documents/GitHub/MACC_svelez/Análisis Estadístico de Datos/bases_datos/insurance.csv")
View(insurance)

base = insurance

library(psych)
multi.hist(x = base[, -c(2,5,6)],
           dcol = c("blue", "red"),
           dtly = c("dotted","solid"),
           main = "")

pairs.panels(x=base,
             ellipses = FALSE,
             lm = TRUE,
             method = "pearson")

#  # # # # #  # # # me faltó 

## independencia

dwtest(modelo1)

## intervalos de confianza y de predicción

## intervalos de confianza para el promedio de y