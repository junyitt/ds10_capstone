con <- file("https://github.com/junyitt/ds10_capstone/raw/master/nlist1.Rdata")
load(con, envir = .GlobalEnv)
close(con)


testnlist <- prep_nlist(testsdf, k = 3)

words.v <- as.data.frame(testnlist[[3]])[,"pre"]

set.seed(124)
sample1 <- sample(1:length(words.v), size = 1000)

testpredict <- lapply(words.v[sample1], FUN = function(word){
      
      pred_df <- p2(word, nlist1, k = 3)
      
      # return(pred_df)
      
      predict <- as.data.frame(pred_df[1:3,"predict"])
      df1 <- t(predict)
      colnames(df1) <- c("pred1", "pred2", "pred3")
      df1
})

testpredict <- do.call(rbind,testpredict)
realtest <- as.data.frame(testnlist[[3]])[sample1,"predict"]

correct1 <- testpredict[,1] == realtest
correct2 <- testpredict[,2] == realtest
correct3 <- testpredict[,3] == realtest
sum(as.logical(correct1+correct2+correct3), na.rm = T)
ss <- sum(correct1)

percentage <- correct/1000
