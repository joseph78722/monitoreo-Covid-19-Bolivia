library(git2r)
library(usethis)

Sys.setenv(RSTUDIO_PANDOC="/Applications/RStudio.app/Contents/MacOS/pandoc")


setwd("/Users/jose/Monitoreo Covid-19 Bolivia/docs")


rmarkdown::render("index.Rmd", encoding="UTF-8")


repo <-  repository()
add(repo, "*")

commit(repo, message = "nuevo")
cred <- cred_token()
push(repo, credentials = cred)


