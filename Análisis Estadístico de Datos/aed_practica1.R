# AED - Práctica 1

library(Epi)
library(dplyr)
library(skimr)
library(ggplot2)
library(GGally)
library(plotly)

dieta = data(diet, package = "Epi")
dieta = na.omit(diet)

# Realizar un descriptivo

skim(dieta)

# Tabla
medidas = dieta %>%
          group_by(as.factor(chd)) %>% 
          summarise(media = mean(weight),
                    mediana = median(weight),
                    desv = sd(weight),
                    cv = round(desv/media*100, 2))
View(medidas)

# De la tabola anterior podemos observar que los pacientes que no presentan
# cardiopatía coronaria pesan en promedio 72.75kg mientras que los que la
# presentan pesan en promedio 70.09.
# 
# En cuanto a la mediana, el 50% de los que presentan cardiopatía pesan 73.21kg
# o menos y el otro 50% más que este valor.
# 
# Al observar la desviación estándar y el coeficiente de variación para ambos
# grupos, se encontró que aunque los que no presentan cardiopatía tienen una
# desviación más alta no son los más dispersos 

# Diagrama de Cajas y bigotes

graf1 = ggplot(dieta, # Base
              aes(x = as.factor(chd), y = weight, fill = as.factor(chd))) +
        geom_boxplot()
graf1

# Diagrama

graf2 = dieta %>% 
        select(height, weight, fibre, fat, chd) %>% 
        transform(chd = factor(chd)) %>% 
        ggpairs(aes(colour = chd, alpha = 0.1))+
        theme_bw()
graf2

# La correlación más alta se encuentra entre las variables peso y estatura, la
# variable cantidad de fibra tiene sesgo a la derecha, mientras que peso y
# estatura son aproximadamente simétricas.

