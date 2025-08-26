# AED práctica 4
# Normal multivariada
# 2025-08-08
# Simón Vélez


library(mvtnorm)

mu = c(150,165);mu
Sigma = matrix(c(25,10,10,20), byrow=TRUE, ncol=2)
Sigma

n = 50
x = seq(from=130, to=170, length.out = n)
y = seq(from=145, to=185, length.out = n)

densidad = function(x,y){
            dmvnorm(cbind(x,y),
            mu,
            Sigma)
}

z = outer(x,y,FUN= "densidad")

persp(x,
      y,
      z,
      theta=45,
      phi=30,
      xlab=" ",
      ylab=" ",
      zlab=" ",
      ticktype = "detailed",
      nticks = 4,
      col = "lightblue"
      )

# Estimación por máxima verosimilitud 

X1 = c(1.9,0.8,1.1,0.1,-0.1,4.4,5.5,1.6,4.6,3.4)
X2 = c(0.7,-1.6,-0.2,-1.2,-0.1,3.4,3.7,0.8,0.0,2.0)

hs = cbind(X1,X2); hs

vm = colMeans(hs);vm
S = cov(hs);S

# Caso Univariado

library(MVN)
library(iris)

## Gráficas

setosa = iris[1:50, 1:4]

### Boxplot

box = univariate_diagnostic_plot(data=setosa, type="box")
box

### Histogramas

setosa = iris[1:50,-5]
g1 = MVN::mvn(data = setosa,#datos
              mvnTest = "royston",
              univariablePlot="histogram")

### Q-Q plots univariados

# FALTA FALTA FALTA FALTA

# Pruebas de normalidad univariadas

# H0: La variable Xi se distribuye normal
# H1: La variable Xi NO se distribuye normal

## Test de Shapiro-Wilks

shapi = mvn(data = setosa,
            univariateTest = "SW",
            desc = TRUE)
shapi$univariate_normality

# Con un nivel de significancia de 0.05, longitud y ancho del sépalo y longitud
# del pétalo cumplen con el supuesto d enormalidad, pues el p-valor > alpha,
# mientras que para el peso del pétalo no se cumple normalidad, pues 
# p-valor < alpha.

### Prueba de Cramer

CV = mvn(data = setosa,
            univariateTest = "CVM",
            desc = TRUE)
CV$univariate_normality



KS = mvn(data = setosa,
         univariateTest = "Lillie",
         desc = TRUE)
KS$univariate_normality

### Anderson

AD = mvn(data = setosa,
         univariateTest = "AD",
         desc = TRUE)
AD$univariate_normality

## Prueba de normalidad Multivariada

### Test de Mardia en MVN

mardia = mvn(data = setosa,
         mvn_test= "mardia",
         desc = TRUE)
mardia$univariate_normality



