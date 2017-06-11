#remove stop_words in a sentence then n-gram
#n-gram then separate words then remove stop words

##are they the same?

View(stop_words)

stopwords <- as.data.frame(stop_words)[,"word"]
str <- "hello i'm a good person accordingly furthermore no man sky"
gsub(paste(stopwords, collapse="|"), "", str)

require(tm)
removeWords(str,stopwords)
