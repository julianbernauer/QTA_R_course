# QTA COURSE 2019 - extracting information exercises 

library(tidyverse)
library(readtext)
library(quanteda)

### 
## Improve the populism dictionary and compare the results

## btw17 corpus 
df_btw17 <- readtext("U:/QTA Kurs CDSS/data/btw2017", encoding="UTF-8-BOM")
corpus_btw17 <- corpus(df_btw17)
docvars(corpus_btw17, "party") <- c("Grüne","Linke","SPD","FDP","CDU","CSU","AfD")

# rooduijn and pauwels 
pop_dict_deu <- dictionary(list(
  populism = c("elit*","konsens*","undemokratisch*","referend*","korrupt*",
             "propagand*","politiker*","täusch*","betrüg*","betrug*",
             "*verrat*","scham*","schäm*","skandal*","*wahrheit*",
             "unfair*","unehrlich*","establishm*","*herrsch*","lüge*") 
)) 



####
## Sentiment of Lion King 
## Get the [Lion King movie (1994) text](https://www.springfieldspringfield.co.uk/movie_script.php?movie=lion-king-the) and compare the sentiment to Taxi Driver 

# Taxi Driver from disk 
df_taxi <- readtext("U:/QTA Kurs CDSS/data/taxidriver.txt", encoding="UTF-8")
taxi_corp <- corpus(df_taxi)
taxi_sent <- dfm(taxi_corp, dictionary = data_dictionary_LSD2015)
taxi_sent



### 
## Exercise readability and lexical diversity 
## EU Speeches (Verena) -> data provided 
# Random sample of English texts: 
# corpus_eu <- corpus(speeches_ep6_cleaned, text_field = "textEN")
# corpus_eu_sample <- corpus_sample(corpus_eu, 100)
# head(summary(corpus_eu_sample))

# Plot readability and lexical diversity against each other, with MPs as labels 

ndoc(corpus_eu_sample)
names(docvars(corpus_eu_sample))

