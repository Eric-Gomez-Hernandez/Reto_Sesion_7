# Desarrollo

# RStudio Cloud y Github

# 1. Crea un repositorio en Github llamado Reto_Sesion_7

# 2. Crea un Project llamado Reto_Sesion_07 dentro de RStudio Cloud 
# utilizando tu cuenta de RStudio, que esté ligado al repositorio recién creado

# 3. Ahora en RStudio crea un script llamado queries.R 
# en donde se conecte a la BDD shinydemo

#install.packages("DBI")
#install.packages("RMySQL")
#install.packages("dplyr")
#install.packages("ggplot2")
library(DBI)
library(RMySQL)
library(dplyr)
library(ggplot2)

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

# 4. Una vez hecha la conexión a la BDD, generar una búsqueda con dplyr
# que devuelva el porcentaje de personas que hablan español en todos los países

# Primero vemos las tablas que contiene esta BDD
dbListTables(MyDataBase)
# De la tabla "CountryLanguaje"atenderemos nuestra solicitud.
DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage")

str(DataDB)
head(DataDB)

porcSpanish <- DataDB %>% filter(Language == "Spanish")
str(porcSpanish)  # Observamos que ya es un dataFrame
names(porcSpanish) # Aqui solo vemos los nombres de los campos.
head(porcSpanish)


# 5. Realizar una gráfica con ggplot que represente este porcentaje de tal 
# modo que en el eje de las Y aparezca el país y en X el porcentaje, 
# y que diferencíe entre aquellos que es su lengua oficial y los que no, 
# con diferente color (puedes utilizar geom_bin2d() ó geom_bar() y coord_flip(),
# si es necesario para visualizar mejor tus gráficas)

porcSpanish %>% ggplot(aes( x = CountryCode, y=Percentage, fill = IsOfficial)) + 
  geom_bar(stat = "identity") +coord_flip()

porcSpanish %>% ggplot(aes( x = CountryCode, y=Percentage, fill = IsOfficial )) + 
  geom_bin2d() +
  coord_flip()

# 6. Una vez hecho esto hacer el commit y push para mandar tu archivo 
# (queries.R), al repositorio de Github Reto_Sesion_7

