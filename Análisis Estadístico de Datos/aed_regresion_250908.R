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