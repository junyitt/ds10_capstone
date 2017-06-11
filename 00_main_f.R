
library(dplyr); library(tidytext); library(tidyr)

ngram.df.f <- function(sdf, k, filter1 = F, stopword = F){

      if(stopword){
            stopwords <- as.data.frame(tidytext::stop_words)[,"word"]
            sdf <- sdf %>% mutate(text = removeWords(text,stopwords))
      }
      
      df <- sdf %>% unnest_tokens(ngram ,text, token = "ngrams", n = k)
      df_count <- df %>% count(ngram, sort = T)
      if(filter1){
            df_count <- df_count %>% filter(n > 1, sort = T)
      }
      
      word.v <- as.data.frame(df_count[,1])[,1]
      word.list <- strsplit(word.v, " ")
      if(k > 1){
            df_count[,"pre"] <- sapply(word.list, FUN = function(x){
                  return(paste(x[1:(k-1)], collapse = " "))
            })
            df_count[,"predict"] <- sapply(word.list, FUN = function(x){
                  return(x[k])
            }) 
      }else{
            df_count[,"pre"] <- df_count[,1]
            maxword <- as.data.frame(df_count %>% filter(n == max(n)) %>% select(ngram))[1,1]
            df_count[,"predict"] <- maxword
      }
      
      return(df_count)
}

prep_nlist <- function(sdf, k){
      nlist <- lapply(1:k, FUN = function(x){
            ngram.df.f(sdf, x)
      })
      return(nlist)
}


lengthword <- function(word1){
      x <- strsplit(word1, " ")[[1]]
      L <- length(x)
      return(L)
}

reduceword <- function(word1){
      
      x <- strsplit(word1, " ")[[1]]
      L <- length(x)
      if(L > 1){
            return( paste(x[2:L], collapse = " ") )
      }else{
            return(word1)
      }
      
}



p2 <- function(word, nlist, k = 3){
      #length of word must be k-1 = 2
      if(lengthword(word) < k-1){
            k = lengthword(word) + 1
      }else if(lengthword(word) == k-1){
            #perfect
      }else{
            while(lengthword(word) > k-1){
                  word <- reduceword(word)
            }
      }
      
      count <- as.data.frame(nlist[[k]] %>% filter(pre == word) %>% summarise(sum(n)))[1,1]
      
      if(count > 0){
            if(k-1 == 1){
                  
                  NN <- as.data.frame(  nlist[[k-1]] %>% filter(pre == word) %>% select(n)   )[1,1]
            }else{
                  NN <- as.data.frame(  nlist[[k-1]] %>% filter(paste(pre,predict) == word) %>% select(n)   )[1,1]
            }
            outdf <- nlist[[k]] %>% filter(pre == word) %>% mutate(p = n/NN)
            return(outdf)
      }else{
            if(k>2){
                  df1 <- p2(reduceword(word), nlist, k-1) 
                  df1[,"p"] <- 0.4*df1[,"p"] 
                  return( df1  )
            }else{
                  
                  outdf <- nlist[[1]] %>% mutate(p = 0.4*max(n)/sum(n))
                  return( outdf )
            }
            
      }
}



