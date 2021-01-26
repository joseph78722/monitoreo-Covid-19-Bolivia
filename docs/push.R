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


