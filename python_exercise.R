## qta course 2019 python exercise 

###
# 1) Tom has confused Python and R and made some other mistakes. Help him clean up his code, 
# one time in Python (from R), and one time in R. 
# Use the reticulate package to run Python from R. 

# Tom's code 
library(quanteda)
library(reticulate)
package(nltk.tokenize)
obama_tweet <- "Zion Williamson seems like an outstanding young man as well as an outstanding basketball player. 
                Wishing him a speedy recovery. https://twitter.com/barackobama."
tokens_obama = tokens(obama_tweet)
tokens_obama
exit()
