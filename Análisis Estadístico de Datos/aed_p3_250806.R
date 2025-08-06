# AED práctica 3 Agosto 6 2025
# Vectores aleatorios

library(readxl)
x <- read_excel("Documents/GitHub/MACC_svelez/Análisis Estadístico de Datos/bases_datos/ejemplo1.xlsx", 
                       col_types = c("numeric", "numeric", "numeric", 
                                     "numeric"))

S = cov(x);S

# 1. Varianza total

VT = sum(diag(S)); VT

# 309.8218

# 2. Varianza Generalizada

VG = det(S); VG

# 0.3402605

# 3. Matriz de correlación

R = cor(x); R

D = diag(diag(S)); D # Este código no es correcto, corregir
D.raiz <- sqrt(D)
D.raiz
