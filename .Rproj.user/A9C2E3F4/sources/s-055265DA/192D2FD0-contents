
setwd("/Users/jose/Vuelos2")
library(git2r)
library(usethis)

repo <-  repository()
add(repo, "*")

commit(repo, message = "nuevo")
cred <- cred_token()
push(repo, credentials = cred)


