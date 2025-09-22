# Regresión lineal

library(dplyr)
library(readr)
library(GGally)

HR_Employee_Attrition <- read_csv("Documents/GitHub/MACC_svelez/Análisis Estadístico de Datos/bases_datos/HR-Employee-Attrition.csv")
View(HR_Employee_Attrition)

df = HR_Employee_Attrition
## Attrition
graf1 = df %>% 
      select(Attrition,Age,MonthlyIncome,TotalWorkingYears) %>% 
      transform(Attrition=factor(Attrition)) %>%
      ggpairs(aes(colour=Attrition,alpha=0.1))+
      theme_bw()
graf1

## Gender
graf2 = df %>% 
  select(Gender,Age,MonthlyIncome,TotalWorkingYears) %>% 
  transform(Gender=factor(Gender)) %>%
  ggpairs(aes(colour=Gender,alpha=0.1))+
  theme_bw()
graf2

# Modelo de regresión

modelo = lm(MonthlyIncome~Age + Gender + TotalWorkingYears, data = df) # primero se ingresa la independiente
summary(modelo)


# Pt2 20250912

library(dplyr)
library(readr)
library(GGally)

HR_Employee_Attrition <- read_csv("Documents/GitHub/MACC_svelez/Análisis Estadístico de Datos/bases_datos/HR-Employee-Attrition.csv")
View(HR_Employee_Attrition)

df = HR_Employee_Attrition

modelo = lm(MonthlyIncome~Age + Gender + TotalWorkingYears, data = df) # primero se ingresa la independiente
summary(modelo)

library(MASS)

sel.AIC =stepAIC(modelo)
sel.AIC

modelo1 = lm(MonthlyIncome ~ Age + TotalWorkingYears, data = df)
summary(modelo1)

# Multicolinealidad

library(psych)

pairs.panels(x = df[,c(1,29)],
             ellipses = FALSE,
             lm = TRUE,
             method = "pearson")
cor(df[,c(1,29)])

corPlot(df[,c(1,29)], method = "number", order="hclust", type="lower")

library(car)

vif(modelo1)

# Linealidad

library(ggplot2)
library(gridExtra)

plot1 = ggplot(data = df, aes(Age, modelo1$residuals))+
        geom_point()+
        geom_smooth(color="firebrick")+
        geom_hline(yintercept = 0)+
        geom_hline(yintercept = 0)+
        theme_bw()

plot2 = ggplot(data = df, aes(TotalWorkingYears, modelo1$residuals))+
  geom_point()+
  geom_smooth(color="firebrick")+
  geom_hline(yintercept = 0)+
  geom_hline(yintercept = 0)+
  theme_bw()

grid.arrange(plot1,plot2)

# Si la relación es lineal los residuos deben distribuirse aleatoriamente
# alrededor de 0, con una variabilidad constante a lo largo del eje x.
# En nuestro caso se cumple linealidad.

# Prueba de los supuestos

## Normalidad

library(MASS)

estudentizados = studres(modelo1)

shapiro.test(estudentizados)
qqPlot(estudentizados, pch = 20)

# Como el p-valor ~= 0 < alpha = 0.05, se rechaza la hipótesis nula, por tanto 
# el supuesto de normalidad se cumple.

# De la gráfica se observa que hay puntos que están muy alejados de la recta y
# no están dentro del área del intervalo.

##

library(lmtest)
bptest(modelo1)

## Independencia

dwtest(modelo1)

# Intervalos de confianza y de predicción

## Intervalo de confianza para el promedio de Y


predict(modelo1,
        list(Age = 35, TotalWorkingYears=20),
        level = 0.95,
        interval = "confidence")

## intervalo de confianza para un valor de Y

predict(modelo1,
        list(Age = 35, TotalWorkingYears=20),
        level = 0.95,
        interval = "prediction")


# Con un, nivel de confianza de 95%, el valor medio del ingreso mensual está
# entre 10513.86 y 11126.16 dólares, mientras que el intervalo al 95% para
# el ingreso mensual de un empleado está entre 4958.693 y 1668.133 dólares.

# Nota: El intervalo de prediccioń es más amplio que el de confianza.

# Análisis de datos atípicos

library(car)
summary(influence.measures(modelo=modelo1))

influencePlot(modelo1)

df[c(86,711),19]
