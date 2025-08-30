# muestras pareadas 

A = c(10.6,9.8,12.3,9.7,8.8)
B = c(10.2, 9.4,11.8,9.1,8.3)

t.test(A,B,
       paired = TRUE,
       alternative = "two.sided")

# Muestra pareada multivariada

library(readr)
aguas <- read_delim("Documents/GitHub/MACC_svelez/Análisis Estadístico de Datos/bases_datos/aguas.csv", 
                    delim = ";", escape_double = FALSE, trim_ws = TRUE)
View(aguas)

# estadístico de prubea

n = nrow(A)
T2 = n*t(vmd) %*% solve(Sd) vmd;T2
p = ncol(A);p
alpha = 0.05

es.prueba=T2/(n-1)*((n-1)/p);es.prueba # estadístico de prueba
f = qf(alpha, p, n-1, lower.tail = FALSE);f

# Como 6.138 < 4.103, se rechaza la hipótesis H0 y por tanto no concuerdan los
# análisis químicos de los dos laboratorios.


# Comparación de dos medias asumiendo matrices de covarianza diferentes

library(readr)
suelos <- read_delim("Documents/GitHub/MACC_svelez/Análisis Estadístico de Datos/bases_datos/suelos.csv", 
                     delim = ";", escape_double = FALSE, trim_ws = TRUE)
View(suelos)

library (dplyr)

cb = suelos %>%
  filter(Bacteria=="CB") # con bacteria

sb = suelos %>% 
  fikter(Bacteria=="SB") # sin bacteria

vm_cb = colMeans(cb[,-1]);vm_cb # vector de medias con bacteria
vm_sb = colMeans(sb[,-1]);vm_sb # vector de medias sin bacteria

S1=cov(cb[,-1]);S1 # matriz de varianzas y covarianzas del suelo con bacteria
S2=cov(sb[,-1]);S1 # matriz de varianzas y covarianzas del suelo sin bacteria

n1 = nrow(cb);n1
n2 = nrow(sb);n2

V1=S1/n1;V1
V2=S2/n2;V2

Se=V1+V2;Se
T2=t(vm_cb-vm_sb)%*%solve(Se)%*%(vm_cb-vm_sb);T2 #T2*

# Grados de libertad

num=(sum(diag(Se))+sum(diag(Se))^2);num
den=(1/(n1-1))*(sum(diag(V1))+sum(diag(V1))^2)+(1/(n2-1))*(sum(diag(V2))+sum(diag(V2))^2);den

v=num/den;v

ph=Hotelling::hotelling.test(cb[,-1],sb[,-1],
                             var.equal=FALSE)
ph$stats #estadístico
ph$pval # pvalor

# con un nivel de significancia de 0.05, se rechaza la hipótesis nula, pues el
# p-valor<alpha. Los datos dan evidencia de que hay diferencias en las medidas
# medias del suelo con bacterias y sin bacterias.

# Pruebas con datos repetidos

perros <- read_delim("Documents/GitHub/MACC_svelez/Análisis Estadístico de Datos/bases_datos/perros.csv", 
                     +     delim = ";", escape_double = FALSE, trim_ws = TRUE)
View(perros)

vm = colMeans(perros[,-1]);vm
S = cov(perros[,-1]);S

n=nrow(perros)
p=ncol(perros[,-1])
C=matrix(c(-1,-1,1,1,
           1,-1,1,-1,
           1,-1,-1,1),
         byrow = TRUE,
         ncol=4);C # C es la matriz de contrastes

T2=n*t(C%*%vm)%*%solve(C%*%S%*%t(C))%*%(C%*%vm);T2

alpha=0.05
f=qf(alpha,p-1,n-p+1,lower.tail = FALSE);f

Fc=((n-p+1)/((n-1)*(p-1)))*T2;Fc

# Con un nivel de significancia de 0.05, se rechaza H0, por tanto existe
# un efecto sobre el ritmo cardiaco de acuerdo a los niveles de presión, alto
# o bajo, con 
  