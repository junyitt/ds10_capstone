nlist <- list(n1df, n2df, n3df)

pf <- function(word, n1df){
    sum1 <- sum(n1df[,"n"])
    u1 <- word == n1df[,1]
    count <- as.data.frame(n1df[u1, "n"])[1,1]
    p <- count/sum1
    return(p)
}

prob <- function(word, nlist, k = 3){
    p <- length(strsplit(word, " ")[[1]])
    tdf <- data_frame(line = 1, text = word) #sample twitter df
    df <- tdf %>% unnest_tokens(ngram ,text, token = "ngrams", n = p)
    word <- as.data.frame(df[,"ngram"])[1,1]
    
    p <- length(strsplit(word, " ")[[1]])
    if(k == p+1){
        #"perfect"
        
    }else if(k > p+1){
        k = p+1
        
    }else if(k < p+1){
        min1 = p-k+2
        word <- paste( strsplit(word, " ")[[1]][(min1):p], collapse = " ")
    }

    
    dftemp <- nlist[[k]]
    # u1 <- word == dftemp[,1]
    # sumtemp <- sum(dftemp[,"n"])
    
    loc <- grep(pattern = paste0("^",word), dftemp[,1])
    tf <- length(loc) > 0
    
    if(tf){
        dftemp2 <- nlist[[k-1]]
        uu <- grep(pattern = paste0("^",word), dftemp2[,1])
            print(paste0("uu = ",uu))
        NN <- sum(dftemp2[uu,"n"])
        df <- dftemp[loc, ] %>% mutate(p = n/NN)
        return(df)
    }else if(!tf & k == 1){
        return(0.4)
    }else if(!tf){
        # df0 <- prob(word, nlist, k-1)
        # df0[,"p"] <- 0.4*df0[,"p"]
        # return(df0)
    }else{
        stop("sum(u1) error!")
    }
    
}

pf("hai", n1df)
prob("hai", nlist, k = 3)

prob(word, nlist, k = 3)
