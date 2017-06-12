library(shiny)
setwd("C:/Users/User/Desktop/DS 10 - Capstone/")

runApp("PredictWord")
# load("nlist2.Rdata")

quant <- sapply(1:3, FUN = function(x){
      kdf <- nlist2[[x]] %>% summarise(quantile(n, 0.95))
      return(as.data.frame(kdf)[1,1] - 1)
})

# quant <- c(60, 5, 1)
# quant <- c(1,1,1)

nlist1 <- lapply(1:3, FUN = function(x){
                  nlist2[[x]] %>% filter(n > quant[x]) %>% select(n, pre, predict)
           })


lapply(1:3, FUN = function(x){
      nlist2[[x]] %>% summarise(quantile(n, 0.95))
})

con <- file("https://github.com/junyitt/ds10_capstone/raw/master/15mb.Rdata")
load(con)
