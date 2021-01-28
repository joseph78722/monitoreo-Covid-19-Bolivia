library(dygraphs)
library(readr)
library(tidyverse)
library(xts)
library(plotly)
library(ggthemes)
library(readr)
library(flexdashboard)
library(viridis)
library(hrbrthemes)
library(highcharter)
library(httr)
library(jsonlite)
library(stringr)
library(stringi)

options(encoding="utf-8")
##### Cargar datos
Confirmados <- read_csv("/Users/jose/Monitoreo Covid-19 Bolivia/data/Confirmados.csv")
Confirmados$Fecha <- as.Date(Confirmados$Fecha)

Recuperados <- read_csv("/Users/jose/Monitoreo Covid-19 Bolivia/data/Recuperados.csv")
Recuperados$Fecha <- as.Date(Recuperados$Fecha)

Fallecidos <- read_csv("/Users/jose/Monitoreo Covid-19 Bolivia/data/Fallecidos.csv")
Fallecidos$Fecha <- as.Date(Fallecidos$Fecha)

Nuevos_casos <- read_csv("/Users/jose/Monitoreo Covid-19 Bolivia/data/Nuevos_casos.csv")
Nuevos_casos$Fecha<- as.Date(Nuevos_casos$Fecha)
####
###### Cargar API
url = "https://covid-193.p.rapidapi.com/statistics"

queryString <- list(country = "bolivia")

headers = add_headers(
  'x-rapidapi-host'= "covid-193.p.rapidapi.com",
  'x-rapidapi-key'= "27116f90b8msh7152626f9b46b5ep16ab32jsn17e2accf574c"
)

API <- GET(url, query = queryString,  headers)
###
#####Agregar datos
datos = fromJSON(rawToChar(API$content))
datos <- datos$response
fecha <- Sys.Date()
acumulado <- datos$cases
acumulado <- acumulado$total

Agregar_confirmado <- data.frame("Fecha" = fecha, 
                                 "Confirmados" = acumulado)

total_Confirmados <- rbind(Confirmados, Agregar_confirmado)
total_Confirmados$Confirmados <- as.integer(total_Confirmados$Confirmados)
setwd("/Users/jose/Monitoreo Covid-19 Bolivia/data")
write.csv(total_Confirmados,"Confirmados.csv", row.names = FALSE)

acumulado_fallecidos <-datos$deaths
acumulado_fallecidos <-acumulado_fallecidos$total

Agregar_fallecidos <- data.frame("Fecha" = fecha, 
                                 "Fallecidos" = acumulado_fallecidos)

total_fallecidos <- rbind(Fallecidos, Agregar_fallecidos)

write.csv(total_fallecidos,"Fallecidos.csv", row.names = FALSE)

acumulado_recuperados <-datos$cases
acumulado_recuperados <-acumulado_recuperados$recovered
Agregar_recuperados <- data.frame("Fecha" = fecha, 
                                  "Recuperados" = acumulado_recuperados)
total_recuperados <- rbind(Recuperados, Agregar_recuperados)
total_recuperados$Recuperados <- as.integer(total_recuperados$Recuperados)
write.csv(total_recuperados,"Recuperados.csv", row.names = FALSE)


registro_nuevos <- datos$cases
registro_nuevos$new <- substr(registro_nuevos$new, star=2, stop=5)

registro_nuevos$new <- as.integer(registro_nuevos$new)
nuevo <- registro_nuevos$new
Agregar_nuevo <- data.frame("Fecha" = fecha, 
                            "Nuevos_casos" = nuevo)
nuevo_nuevos_casos<- rbind(Nuevos_casos, Agregar_nuevo) 
write.csv(nuevo_nuevos_casos,"Nuevos_casos.csv", row.names = FALSE)


nuevas_muertes <- datos$deaths
nuevas_muertes$new <- substr(nuevas_muertes$new, star=2, stop=4)
nuevas_muertes <- nuevas_muertes$new

activos <- datos$cases
activos <- activos$active
activos <- as.integer(activos)

Dato_total_muertos <- tail(total_fallecidos$Fallecidos, 1)
Dato_total_muertos <- as.integer(Dato_total_muertos)
Titulo_nuevos_casos<- if_else(max(nuevo_nuevos_casos$Nuevos_casos) == tail(nuevo_nuevos_casos$Nuevos_casos, 1), print("Bolivia registra un récord de", encoding = "UTF-8"), print("Bolivia registra", encoding = "UTF-8"))

Dato_nuevos_casos <- tail(nuevo_nuevos_casos$Nuevos_casos, 1)
Dato_nuevos_casos <- as.integer(Dato_nuevos_casos)

Dato_acumulado<- tail(total_Confirmados$Confirmados, 1)
Dato_acumulado <- as.integer(Dato_acumulado)

Lead_nuevos_casos <- if_else(max(nuevo_nuevos_casos$Nuevos_casos) == tail(nuevo_nuevos_casos$Nuevos_casos, 1), print("Bolivia registró esta joranada un récord de", encoding = "UTF-8"), print("Bolivia registró esta jornada", encoding = "UTF-8"))
Datos_nuevas_muertes <- max(nuevas_muertes, na.rm = FALSE)
Datos_nuevas_muertes <- as.integer(Datos_nuevas_muertes)
Datos_recuperados <- tail(total_recuperados$Recuperados, 1)
Datos_recuperados <- as.integer(Datos_recuperados)


format(Dato_nuevos_casos, digits=1, big.mark=",")
format(Dato_nuevos_casos, big.mark = ",")       
options()  

library(rmarkdown); sessionInfo()

Sys.setlocale("LC_CTYPE", "")
segun <- paste0("según")
stri_enc_toutf8(segun, is_unknown_8bit = FALSE, validate = FALSE)

x <- "Maurício"
y <- c(x, Encoding(x))

stri_enc_toutf8(x, is_unknown_8bit = FALSE, validate = FALSE)

##########

library(git2r)
library(usethis)
library(rmarkdown)
library(knitr)


setwd("/Users/jose/Monitoreo Covid-19 Bolivia/docs")
Sys.setlocale("LC_CTYPE", "")

Sys.setenv(RSTUDIO_PANDOC="/Applications/RStudio.app/Contents/MacOS/pandoc")


rmarkdown::render("index.Rmd", encoding='UTF-8')


repo <-  repository()
add(repo, "*")

commit(repo, message = "nuevo")
cred <- cred_token()
push(repo, credentials = cred)


