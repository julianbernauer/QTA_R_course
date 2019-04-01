# QTA Course 2019 
# Twitter data - intro to rtweet and quanteda processing 

library(tidyverse)
library(readtext)
library(quanteda)
library(rtweet)

## NOTE: 
# rtweet used with browser authentification, 
# pops up when it's used for the first time 


# Collecting 100 most recent Tweets containing #KrampKarrenbauer
krakar_hash <- search_tweets("#KrampKarrenbauer", n = 100, include_rts = FALSE)

# Look at all this information! some is missing, though, such as geolocation... 
ls(krakar_hash)
View(krakar_hash)


# Collecting Tweets for a certain time with key words - actual fishing expedition  
stream_tweets(q = "Merkel", timeout = 60, file_name = "merkel.json", parse = FALSE)
merkel_key <- parse_stream("merkel.json")
View(merkel_key)
# save(merkel_key,file="U:/merkel.Rda")


# Most recent Tweets from @akk, removing retweets (only n-retweets retained)
krakar_tml <- get_timelines(c("akk"), n = 200, include_rts = FALSE)
View(krakar_tml)


# A quanteda corpus of Tweets - works directly 
krakar_tml_corpus <- corpus(krakar_tml)
ndoc(krakar_tml_corpus)
summary(krakar_tml_corpus)[1:20,1:9]


## Doing some processing with tokens() 

# Previously stored data, retrieved on March 27 
# saveRDS(krakar_tml_corpus, file = "U:/krakar_tml_190327.Rds")
krakar_tml_corpus0327 <- readRDS("U:/krakar_tml_190327.Rds")

# Text without processing 
texts(krakar_tml_corpus0327)[11]

# Removing urls 
# quanteda recommends "fasterword", a "dumber but faster" method, 
# affects the way punctuation is treated 
krakar_toks_url1 <- tokens(krakar_tml_corpus0327, what = "fasterword", remove_url = TRUE)
krakar_toks_url1[11]

# here, it works with "word" as well 
krakar_toks_url2 <- tokens(krakar_tml_corpus0327, what = "word", remove_url = TRUE)
krakar_toks_url2[11]

# removing url and punctuation 
krakar_toks_punct <- tokens(krakar_tml_corpus0327, what = "word", remove_url = TRUE, remove_punct = TRUE)
krakar_toks_punct[11]

# removing url, punctuation and # as well as @ (while keeping text)
krakar_toks_txt <- tokens(krakar_tml_corpus0327, what = "word", remove_url = TRUE, remove_punct = TRUE, remove_twitter=TRUE)
krakar_toks_txt[11]

# Selecting only handles and hashtags
krakar_toks_haha <- tokens_select(krakar_toks_punct, pattern = "^[#@].+$", valuetype = "regex")
krakar_toks_haha[11]

# only text, removing hashtags and handles -> probably not desired 
krakar_toks_textnoha <- tokens_remove(krakar_toks_punct, pattern = "^[#@].+$", valuetype = "regex")
krakar_toks_textnoha[11]


# kwic 
head(kwic(krakar_toks_txt, "europa", window = 6))


# dfm on text while removing stopwords 
krakar_dfm <- dfm(krakar_toks_txt, remove = stopwords("german"))
head(krakar_dfm, 10, n = 10)


# most frequent words 
topfeatures(krakar_dfm, n = 10)


# Plot the most frequent words 
frequ <- as.numeric(topfeatures(krakar_dfm,10))
word <- as.character(names(topfeatures(krakar_dfm, 10)))
krakar_plot <- as.data.frame(frequ,word)

ggplot(krakar_plot, aes(x = reorder(word, frequ), y = frequ)) +
  geom_point() +
  coord_flip() +
  labs(x = NULL, y = "Frequency")


## Some textual analysis will be done in the other example
