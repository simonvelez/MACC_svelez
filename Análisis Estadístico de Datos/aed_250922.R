# Análisis de componentes principales 250922

library(redr)
ACP1 <- read_delim("Documents/GitHub/MACC_svelez/Análisis Estadístico de Datos/bases_datos/ACP1.csv", 
                  delim = ";", escape_double = FALSE, trim_ws = TRUE)
View(ACP1)

# # # # # # # # # # # # 
# Datos sin centrar   # 
# # # # # # # # # # # # 

X = ACP1

colMeans(X[,c(1,3)])
cov(X[,c(1,3)]) # matriz de varianzas y covarianzas
cor(X[,c(1,3)]) # matriz de correlación

VT = sum(diag(cov(ACP1[, -c(2,4)]))); VT # varianza total
#Variabilidad retenida
variab.retenida = round(diag(cov(ACP1[,c(1,3)]))/VT*100,2); variab.retenida

# # # # # # # # # # # # 
# Datos centrados     # 
# # # # # # # # # # # # 

colMeans(X[,c(2,4)])
cov(X[,c(2,4)])
cor(X[,c(2,4)])

VTC = sum(diag(cov(ACP1[, c(2,4)]))); VTC
variab.retenida.c = round(diag(cov(ACP1[,c(2,4)]))/VTC*100,2); variab.retenida.c

# Podemos observar que la matriz de correlación, varianzas y covarianzas 
# para ambos grupos es la misma, es decir, con los datos centrados y sin centrar.


# Nuevo eje

t = 10
theta = t*pi/180;
y1 = cos(theta)*X$XC1+sin(theta)*X$XC2;y1

# Nueva variable

X$Y1 = y1

mean(X$Y1)
var(X$Y1)

covarianza1 = cov(X[,c(2,4,5)])
VT1 = sum(diag(covarianza1)); VT1
covarianza1[3,3]/VT1*100

# Nuevos ángulos

theta = 43.261*pi/180;theta

y1 = cos(theta)*X$XC1 + sin(theta)*X$XC2;y1
X$Y1 = y1

y2 = -sin(theta)*X$XC1+cos(theta)*X$XC2;y2
X$Y2 = y2

cov(X[,c(5,6)])
VT.nv=sum(diag(cov(X[,c(5,6)]))); VT.nv

# Variabilidad retenida

variab.retenida.nv = round(diag(cov(X[,c(5,6)]))/VT.nv*100,2);variab.retenida.nv

cor(X[,c(5,6)])


