## QTA course 2019 Python exercise 

###
# 1) Tom has confused Python and R and made some other mistakes. 
# Help him clean up his code in Python (from R), and also in R. 
# a) Use the reticulate package to run Python from R. 
# b) Access the object produced with Python in R 
# c) Translate to R using quanteda (function tokens). 
# c) Remove punctuation and the url in R. 

# Tom's code 
library(quanteda)
library(reticulate)
package(nltk.tokenize)
obama_tweet <- "Zion Williamson seems like an outstanding young man as well as an outstanding basketball player. Wishing him a speedy recovery. https://twitter.com/barackobama."
tokens_obama = tokens(obama_tweet)
tokens_obama
exit()

# a) Python code, using REPL
library(reticulate)
repl_python()
from nltk.tokenize import word_tokenize
obama_tweet = "Zion Williamson seems like an outstanding young man as well as an outstanding basketball player. Wishing him a speedy recovery. https://twitter.com/barackobama."
tokens_obama_p = word_tokenize(obama_tweet)
print(tokens_obama_p)
exit

# b) After returning to R, access objects with 'py$OBJECT_NAME', such as 'py$tokens_obama_p'
py$tokens_obama_p
View(py$tokens_obama_p)

# c) R code 
library(quanteda)
obama_tweet <- c("Zion Williamson seems like an outstanding young man as well as an outstanding basketball player. Wishing him a speedy recovery. https://twitter.com/barackobama.")
tokens_obama_r <- tokens(obama_tweet)
tokens_obama_r

# d) R code, removing punctuation and url 
# and making R talkative with verbose=TRUE 
library(quanteda)
obama_tweet <- c("Zion Williamson seems like an outstanding young man as well as an outstanding basketball player. Wishing him a speedy recovery. https://twitter.com/barackobama.")
tokens_obama_r2 <- tokens(obama_tweet, what="word", 
                          remove_url=TRUE, remove_punct=TRUE, 
                          verbose=TRUE)
tokens_obama_r2


###
# 2) Run this Python code relying on an interactive Python console within R (REPL) 
# a) using imported modules. 
# (b) Transform the text to lowercase using some additional Python code and print it.) 
# Notes: 
# - example following https://www.nltk.org/book/ch03.html 
# - py_install("urllib") if necessary 
# - What are we trying to extract here? 

# REPL
library(reticulate)
repl_python()
from urllib import request
url = "http://www.gutenberg.org/files/74/74.txt"
response = request.urlopen(url)
raw = response.read().decode('utf8')
type(raw)
len(raw)
raw[:300]
exit

# a) imported modules 
library(reticulate)
urllib <- import("urllib")
url <- c("http://www.gutenberg.org/files/74/74.txt") 
response <- urllib$request$urlopen(url)
raw <- response$read()$decode('utf8')
typeof(raw)
nchar(raw)
substr(raw,1,300)

# b) lowercase 
# py_install("nltk") if necessary 
library(reticulate)
repl_python()
from urllib import request
import nltk
url = "http://www.gutenberg.org/files/74/74.txt"
response = request.urlopen(url)
raw = response.read().decode('utf8')
type(raw)
len(raw)
raw[:300]
raw = raw.lower()
raw[:300]
exit

