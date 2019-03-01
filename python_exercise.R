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
