# Análisis Estadístico de datos

corchos <- read.csv("~/Downloads/corchos.csv", sep=";")
View(corchos)

C = matrix(c(1,0,-1,0,0,1,0,-1), byrow = TRUE, ncol = 4)
C

n = nrow(corchos);n
p = ncol(corchos);p
vm = colMeans(corchos);vm #vector de medias
S = cov(corchos);S #matriz de varianzas y covarianzas

alpha = 0.05 # nivel de significancia
k = nrow(C);k # grados de libertad 1


T2 = n*t(C%*%vm)%*%solve(C%*%S%*%t(C))%*%(C%*%vm); T2
f = qf(alpha,k,n-p,lower.tail = FALSE);f

Fc = (n-k)*T2/(k*(n-1));Fc