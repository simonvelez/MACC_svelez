# Análisis de correlación lineal
# Probabilidad y estadística 2

# Carga de paquetes ----------

if (!require('RColorBrewer')) install.packages('RColorBrewer')
if (!require('corrplot')) install.packages('corrplot')
if (!require('GGally')) install.packages('GGally')
if (!require('tidyverse')) install.packages('tidyverse')

# Lectura de datos ----------

datos_mtcars <- read_excel("Datos_mtcars.xlsx")
  
# Preparación y exploración de datos ----------
  
Datos_mtcars %>% dim()
Datos_mtcars %>% glimpse()

# Cambiar tipología a las variables categóricas
Datos_carros <- Datos_mtcars %>%
  mutate(vs = as.factor(vs),
         am = as.factor(am))

Datos_carros %>% glimpse()


# Diagramas de dispersión ----------
# entre dos variables

Datos_carros %>% 
  ggplot(aes(x = mpg, y = disp))+geom_point()



# con más formato

Datos_carros %>%
  ggplot(aes(x=mpg, y = disp, color = am))+
  geom_point()+
  ggtitle("Diagrama de dispersión\n mpg vs disp")+
  xlab("mpg")+
  ylab("disp")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

# entre todos los pares de variables

ggpairs(Datos_carros)

Datos_carros %>% 
  select_if(is.numeric) %>% 
  ggpairs()

Datos_carros %>% 
  select_if(is.numeric) %>% 
  ggpairs(aes(colour = Datos_carros$am))

# Coeficiente de correlación ----------
# entre dos variables

cor(Datos_carros$mpg, Datos_carros$disp)

# Matriz de correlación

Datos_carros %>% 
  select_if(is.numeric) %>% 
  cor() %>% 
  round(3)

# Diagrama de correlación


Datos_carros %>% 
  select_if(is.numeric) %>% 
  cor() %>% 
  corrplot(
         method = "number",
         type = "upper" #show only upper side
)




Datos_carros %>% 
  select_if(is.numeric) %>% 
  cor() %>% 
  corrplot(method = "square", tl.cex = 0.7,
         col=brewer.pal(n=8, name="PuOr"),addCoef.col = "black",
         number.cex=0.7,type = "upper", diag = FALSE)

