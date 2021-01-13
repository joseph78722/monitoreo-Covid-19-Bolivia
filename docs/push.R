library(knitr)
library(shiny)
library(git2r)
library(usethis)
setwd("/Users/jose/Monitoreo Covid-19 Bolivia/docs")
rmarkdown::render("index.Rmd")


repo <-  repository()
add(repo, "*")

commit(repo, message = "nuevo")
cred <- cred_token()
push(repo, credentials = cred)

