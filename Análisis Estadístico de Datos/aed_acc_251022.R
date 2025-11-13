# Análisis de correlación canónica ACC

library(readxl)
hipoteticos <- read_excel("Documents/GitHub/MACC_svelez/Análisis Estadístico de Datos/bases_datos/hipoteticos.xlsx")
View(hipoteticos)  

library(CCA)
X=hipoteticos[,c(1,2)];X
Y=hipoteticos[,c(3,4)];Y

mat_cor = matcor(X,Y); mat_cor

# Normalidad para cada grupo

library(MVN)

# Normalidad multivariada para X

mvn(data = as.data.frame(X), 
    univariate_test = "SW")$univariate_normality

mvn(data = as.data.frame(Y), 
    univariate_test= "SW")$univariate_normality

# Construcción del método
cca = cc(X,Y);cca

# Coeficientes, las ponderaciones de las combinaciones

coef_ca=cca[3:4];coef_ca

#correlaciones canónicas, sqrt de los valores propios

cor_ca=cca$cor;cor_ca

#valores propios
cor_ca^2

#correlaciones entre U y X
cor(cca$scores$xscores,X)

#correlaciones entre V y Y
cor(cca$scores$yscores,Y)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# Ejemplo 2 

library(readxl)
mariposas <- read_excel("Documents/GitHub/MACC_svelez/Análisis Estadístico de Datos/bases_datos/mariposas.xlsx")
View(mariposas)

X = mariposas[,c(6:11)];X
Y = mariposas[,c()]

