# Python from R 
# Code from slides QTA_Course_04_python_R

# Using the reticulate package 
library(reticulate)

# If you need to install Python modules 
# py_install("nltk")

## Python from R - REPL 
# Opens an interactive Python session from within R.

# Enter Python 
repl_python()

# Python code within REPL 
from nltk.tokenize import word_tokenize
obama_tweet = "Zion Williamson seems like an outstanding young man as well as an outstanding basketball player. Wishing him a speedy recovery. https://twitter.com/barackobama."
obama_repl = word_tokenize(obama_tweet)
print(obama_repl)

# Don't forget to exit 
exit

# After returning to R, access objects with "py$NAME". 
obama_repl
py$obama_repl


## Python from R - 'import()' 
# Import Python module, access function with "NAME_MODULE$NAME_FUNCTION".*

# R code 
obama_tweet <- "Zion Williamson seems like an outstanding young man as well as an outstanding basketball player. Wishing him a speedy recovery. https://twitter.com/barackobama."
nltk.tokenize <- import("nltk.tokenize")
obama_import <- nltk.tokenize$word_tokenize(obama_tweet)
obama_import


## Python from R - `source()` 
# Sources the code: external Python script, runs in background, results available in R.
# Script 'obama.py' (see GitHub), saved on disk

# Sourcing:
source_python("obama.py")

# Results directly available:
obama_source

