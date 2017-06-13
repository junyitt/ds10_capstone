setwd("~/Desktop/DS 10 - Capstone/Coursera-SwiftKey/final/en_US")
con <- file("en_US.twitter.txt", "r"); us_twitter <- readLines(con); close(con)
con2 <- file("en_US.news.txt", "r"); us_news <- readLines(con2); close(con2)
con3 <- file("en_US.blogs.txt", "r"); us_blogs <- readLines(con3); close(con3)


summary(us_twitter)
summary(us_news)
summary(us_blogs)
summary(nchar(us_twitter))
summary(nchar(us_news))
summary(nchar(us_blogs))

# install.packages("tidytext")
#top 10 most frequent word, what what follow after it, sort by frequency

library(dplyr); library(tidytext); library(ggplot2)
library(igraph); library(ggraph)
visualize_bigrams <- function(bigrams) {
    set.seed(2016)
    a <- grid::arrow(type = "closed", length = unit(.15, "inches"))
    
    bigrams %>%
        graph_from_data_frame() %>%
        ggraph(layout = "fr") +
        geom_edge_link(aes(edge_alpha = n), show.legend = FALSE, arrow = a) +
        geom_node_point(color = "lightblue", size = 5) +
        geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
        theme_void()
}


set.seed(122)
subset1 <- sample(1:length(us_twitter))[1:100000] 
subset2 <- sample(1:length(us_news))[1:100000] 
subset3 <- sample(1:length(us_blogs))[1:100000] 

twitter_sdf <- data_frame(line = subset1, text = us_twitter[subset1], dataType = "twitter") #sample twitter df
news_sdf <- data_frame(line = subset2, text = us_news[subset2], dataType = "news") #sample news df
blogs_sdf <- data_frame(line = subset3, text = us_blogs[subset3], dataType = "blogs") #sample blogs df

sdf <- rbind(twitter_sdf, news_sdf, blogs_sdf)

########EXPLORE


tidy_df1 <- sdf %>% unnest_tokens(word, text)

count_df <- tidy_df1 %>% anti_join(stop_words) %>% group_by(dataType) %>% count(word, sort = T)

count_df %>%
    filter(n > 1000) %>%
    mutate(word = reorder(word, n)) %>%
    ggplot(aes(word, n)) +
    geom_col() +
    xlab(NULL) +
    coord_flip()


bigram_df <- sdf %>% unnest_tokens(bigram ,text, token = "ngrams", n = 2)

count_bigram_df %>% count(bigram, sort = T)

sep_df <- bigram_df %>% separate(bigram, c("word1", "word2"), sep = " ")
bigram_filtered <- sep_df %>%
    filter(!word1 %in% stop_words$word) %>%
    filter(!word2 %in% stop_words$word)
bigram_count <- bigram_filtered %>% count(word1, word2, sort = T)
bigram_graph <- bigram_count %>% filter(n > 200) 

print(bigram_graph)


# bigram_graph %>% graph_from_data_frame()

bigram_graph %>% visualize_bigrams()

trigram_df <- sdf %>% unnest_tokens(bigram ,text, token = "ngrams", n = 3)
sep3_df <- trigram_df %>% separate(bigram, c("word1", "word2", "word3"), sep = " ")
G <- sep3_df %>% filter(word1 == "case" & word2 == "of")
View(G %>% count(word3, sort = T))
# 
# sum(grepl("love", a))/sum(grepl("hate", a))
# u1 <- grep("biostats", a)
# a[u1]
# 
# g <- grepl("A computer once beat me at chess, but it was no match for me at kickboxing", a)
# sum(g)
# 
# a[g]
