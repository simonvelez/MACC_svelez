# AED 01 09 2025

# ANOVA

library(readr)
tecnicas <- read_delim("Documents/GitHub/MACC_svelez/Análisis Estadístico de Datos/bases_datos/tecnicas.csv", 
                       delim = ";", escape_double = FALSE, trim_ws = TRUE)
View(tecnicas)

modelo = aov(tecnicas$Cantidad ~ tecnicas$Metodo)
modelo

ANOVA = anova(modelo);ANOVA

gl1 = ANOVA$Df[1]; gl1
gl2 = ANOVA$Df[2]; gl2

f = qf(0.5,gl1,gl2,lower.tail = FALSE)

# Comparaciones múltiples

library(agricolae)
library(car)

# Prueba Tukey

IntervaloTuk = TukeyHSD(modelo, conf.level = 0.95)

plot(IntervaloTuk)

boxplot(tecnicas$Cantidad~tecnicas$Metodo)

# Prueba LSD

interLSD=LSD.test(tecnicas$Cantidad,#variab cuanti
                  tecnicas$Metodo,#variable cuali
                  DFerror = ANOVA$Df[2],#gl error
                  MSerror = ANOVA$`Mean Sq`[2],#cuadrados medios
                  console = TRUE)

plot(interLSD)

# Prueba de Shapiro-Wilk

error=modelo$residuals

shapiro.test(error)


# H_0: errores se distribuyen normal
# H_1: errores NO se distribuyen normal

# Con alpha = 0.05, P-valor = 0.3558, NO se rechaza la hipótesis nula, por lo
# tanto el supuesto de normalidad se cumple





# Supuesto de varianza constante

library(stats)
bartlett.test(error~tecnicas$Metodo)


# H_0: la varianza de los errores es la misma
# H_1: la varianza de los errores NO es la misma

# Con alpha=0.05, p-value = 0.8152, NO se rechaza la hipótesis nula, por lo que
# el supouesto de varianza se cumple.



# Supuesto de independencia

library(lmtest)
dwtest(modelo)


# H_0: los errores son independientes
# H_1: los errores NO son independientes

# Con alpha de 0.05, p-value = 0.7843, NO se rechaza la hipótesis nula, por lo que el supuesto
# de independencia se cumple.
