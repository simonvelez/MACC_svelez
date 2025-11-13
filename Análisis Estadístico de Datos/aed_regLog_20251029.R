# Regresión logística

library(tidyverse)
library(ISLR)

# A simulated data set containing information on ten thousand customers.
# The aim here is to predict which customers will default (impago) on their
# credit card debt.

datos = Default

# Ajuste de un modelo lineal por mínimos cuadrados

modelo_lineal <- lm(default ~ balance, data = datos)

datos = datos %>% 
  select(default, balance) %>% 
  mutate(default = recode(default,
                          "No" = 0, # sí paga, no incumple
                          "Yes" = 1))# no paga, sí incumple

# Ajuste de un modelo logístico.
modelo_logistico <- glm(default ~ balance, data = datos, family = "binomial")


# Con geom_smooth se puede obtener el gráfico directamente.
ggplot(data = datos, aes(x = balance, y = default)) +
  geom_point(aes(color = as.factor(default)), shape = 1) + 
  geom_smooth(method = "glm",
              method.args = list(family = "binomial"),
              color = "gray20",
              se = FALSE) +
  theme_bw() +
  theme(legend.position = "none")


summary(model)


# Ejemplo Churn

library(readr)
Churn <- read_delim("Documents/GitHub/MACC_svelez/Análisis Estadístico de Datos/bases_datos/Churn.csv", 
                    delim = ";", escape_double = FALSE, trim_ws = TRUE)
View(Churn)

# Gráfica de datos faltantes

library(DataExplorer)

plot_missing(Churn)

Churn = na.omit(Churn)

Churn = Churn[,-1] # quitar la primera fila

plot_missing(Churn)


datos = Churn
plot_intro(datos)

# Análisis para cada variable cuali

vc = datos %>% 
  gather() %>% 
  ggplot(aes(value))+
  geom_bar()+
  facet_wrap(~key,scales = "free")+
  theme(axis.text = element_text(size = 4))
vc

# Transformación de la variable respuesta

datos = datos %>%
        mutate(Permanencia = dplyr::recode(Churn, "No" = 0, "Yes" = 1)) %>% 
        transform(Permanencia = factor(Permanencia))

datos = datos[,-20]


# particionamos la base en dos, una de entrenamiento y otra prueba

# Semilla

set.seed(29102025)

n = nrow(datos)
filas = sample(1:n, round(n * 0.7)) # seleccionando las filas

entrenamiento = datos[filas,] # base de entrenamiento
prueba = datos[-filas,] # base de prueba


# Ajuste de un modelo logístico

## Modelo 1

modelo1 = glm(Permanencia~InternetService +
                Contract + PaymentMethod + tenure + MonthlyCharges,
              data = entrenamiento, family=binomial)

summary(modelo1)

# Mejor modelo por AIC

modelo_optimo = step(modelo1, direction = "both")

#Mejor modelo seleccionado por AIC


