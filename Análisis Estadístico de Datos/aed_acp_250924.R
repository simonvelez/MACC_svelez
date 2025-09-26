# Análisis de Componentes Principales

library(datasets)
data("USArrests")

# El objetivo es reducir la dimensión
# Las componentes son combinaciones lineales de las variables originales, NO
# están correlacionadas.

# Ejemplo introductorio

## Calculamos las varianzas

apply(X=USArrests,
      MARGIN = 2,
      FUN = var)

# Observamos de la salida que la variable "asaltos" tiene el promedio y la
# varianza maś alto, para realizar un ACP es importante escalar para la variable
# con más variabilidad no tenga todo el peso en la componente.

## Matriz de varianzas y covarianzas

cov(USArrests)
cor(USArrests)

# De la salida anterior podemos observar que la correlación más alta se encuentra
# entre asaltos y asesinatos, mientras que la más baja es población urgaba y
# asesinato.



#Realizamos ACP, estandarizando las variables

acp=prcomp(USArrests,#datos
           scale=TRUE#para que estandarice, las desv estándar es 1
)
names(acp)

#valores de las cargas para cada componente (vector propio)

round(acp$rotation,3)

# Z1 = PC1 = -0.536 Murder - 0.583 Assault - 0.278 UrbanPop - 0.543 Rape

# Un posible nombre relacionado con la primera componente sería los delitos

# Un posible nombre relacionado con la segunda componente sería lo correspondiente
# a población.

#Valor de las componenetes para cada observación

## con los datos centrados
head(acp$x)

# Alabama = -0.536((13.2-prom) /desv) - 0.583((236-prom) / desv) y así :3

# Componentes a seleccionar

library(factoextra)

#gráfico para seleccionar las componentes
fviz_eig(acp,
         addlabels = TRUE,
         ylim=c(0,80))

prop_varianza      <- acp$sdev^2 / sum(acp$sdev^2)
prop_varianza

#transformar los datos
biplot(x=acp,scale=0,cex=0.6,
       col=c("blue4","red"))

library(FactoMineR)
library(factoextra)
res.pca=PCA(USArrests,graph=FALSE)
print(res.pca)





