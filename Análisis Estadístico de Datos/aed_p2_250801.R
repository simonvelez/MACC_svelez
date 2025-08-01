# AED práctica 2 Agosto 1 2025
# Análisis descriptivo (cont.) y repaso de álgebra

library(Epi)
library(dplyr)
library(skimr)
library(ggplot2)
library(GGally)
library(plotly)
library(moments)

dieta = data(diet, package = "Epi")
dieta = na.omit(diet)

## Covarianza

covarianza = round(cov(dieta[,c(9:13)]),3) # Covarianza
covarianza

## Correlación

correlaciones = round(cor(dieta[,c(9:13)]),3)
correlaciones

# De la matriz se puede observar que [no alcancé a anotar :(]

## Promedios

promedios = colMeans(dieta[,c(9:13)])
promedios

# El promedio de ingesta total por día es de 28.34cal.

## Curtosis

kurtosis(dieta[,c(9:13)])

# energy   height   weight      fat    fibre 
# 3.534859 3.030497 2.911992 3.756544 9.836587 

# Las variables peso y estatuta son mesocúrticas (k cercano a 3) muentras que 
# fibra es leptocúrtica (k > 3).

## Simetría

skewness(dieta[,c(9:13)])

# energy     height     weight        fat      fibre 
# 0.4305991 -0.1451789  0.1329393  0.6189497  1.6812930 


## Repaso de álgebra

X = c(1,4);X
Y = c(5,1);Y
Z = c(4,-2);Z

X+Y+Z
X + Y - 2*Z

# Transpuesta
xt = t(X); xt

# Matriz de ceros
matriz.ceros = matrix(0, nrow = 3, ncol = 3); matriz.ceros

# Matriz de unos
matriz.unos = matrix(1, nrow = 3, ncol = 3); matriz.unos

# Matriz identidad

matriz.identidad = diag(1, nrow = 3); matriz.identidad

# Ejercicio matrices 4x3

A = matrix(c(2,-3,1,0,1,5,4,5,3,0,-1,6), byrow = TRUE, ncol = 4);A

B = matrix(c(4,7,-1,2,0,6,3,1,-2,1,1,4), byrow = TRUE, ncol = 4);B

A + B # suma
t(A)%*%B # multiplicación
dim(A) # dimensión

# Determinante y valores propios

A = matrix(c(20,18,17,19,25,23,21,34,27), byrow = TRUE, ncol = 3);A
det(A) # determinanete
eigen(A) # valores y vectores propios

library(matrixcalc)
is.positive.definite(matrix(c(4,2,2,4), byrow = TRUE, ncol = 2))

solve(A) # inversa de una matriz
matrix.inverse(A) # otra forma de hacerlo

## Dibujando en 3D

library(plot3D)
library(datasets)
datos = data(iris)
datos = iris 

scatter3D(datos$Sepal.Length,
          datos$Sepal.Width,
          datos$Petal.length,
          phi = 0,
          bty = "g",
          pch = 20,
          cex = 2,
          ticktype = "detailed")

# Gráfico interactivo [falta corregir]

plot_ly(data=datos,
        x =~datos$Sepal.Length,
        y =~datos$Sepal.Width,
        col =~datos$Species,
        text = paste("Especie:", datos$Species,
                      "<br>Longitud del sépalo:"Sepal.Length,
                      "<br>Ancho del sépalo:"Sepal.Width),
        mode = "markers",
        type = "scatter",
        marker = list(size = 10, opacity = 0.8)) %>% 
        layout(title = "Gráfico interactivo",
               xaxis = list(title = "Longitud del sépalo"),
               yaxis = list(title = "Ancho del sépalo"),
               hovermode = "closest")


