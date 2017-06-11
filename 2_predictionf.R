
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
        NN <- as.data.frame(  nlist[[k-1]] %>% filter(ngram == word) %>% select(n)   )[1,1]
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


