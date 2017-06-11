setwd("C:/Users/User/Desktop/DS 10 - Capstone/")
load("nlist2.Rdata")

k <- 800000

setwd("C:/Users/User/Desktop/DS 10 - Capstone/Coursera-SwiftKey/final/en_US")
con <- file("en_US.twitter.txt", "r"); us_twitter <- readLines(con, k); close(con)
con2 <- file("en_US.news.txt", "r"); us_news <- readLines(con2, k); close(con2)
con3 <- file("en_US.blogs.txt", "r"); us_blogs <- readLines(con3, k); close(con3)

library(function0)
packages <- c("dplyr", "tidyr", "tidytext", "ggplot2", "tm", "igraph", "ggraph")
library0(packages)
library(dplyr); library(tidytext); library(ggplot2);library(tidyr)
library(igraph); library(ggraph)

sub = 100000
set.seed(100)
subset1 <- sample(1:length(us_twitter))[1:sub] 
subset2 <- sample(1:length(us_news))[1:sub] 
subset3 <- sample(1:length(us_blogs))[1:sub] 
twitter_sdf <- data_frame(line = subset1, text = us_twitter[subset1], dataType = "twitter") #sample twitter df
news_sdf <- data_frame(line = subset2, text = us_news[subset2], dataType = "news") #sample news df
blogs_sdf <- data_frame(line = subset3, text = us_blogs[subset3], dataType = "blogs") #sample blogs df

sdf <- rbind(twitter_sdf, news_sdf, blogs_sdf)

setwd("C:/Users/User/Desktop/DS 10 - Capstone/")
source("./00_main_f.R")
source("./2_predictionf.R")


nlist <- prep_nlist(sdf, k = 4)
nlist2 <- prep_nlist(sdf, k = 8)



