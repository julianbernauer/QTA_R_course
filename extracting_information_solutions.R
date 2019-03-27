# QTA COURSE 2019 - extracting information exercises 

library(tidyverse)
library(readtext)
library(quanteda)

# 1) Dictionaries 
# Improve the dictionary and compare the results, see exercise code


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

# change to subcategories, add sovereignty, referendums... 
pop_dict_deu2 <- dictionary(list(
  people = c("*volk*"), 
  sovereignty = c("direkt*","*souver*","undemokrat*","referend*"), 
  elites = c("*elite*","politiker*","*establishm*","*herrsch*"),
  blame = c("korrupt*","*propagand*","*täusch*","betrüg*","*verrat*","scham*","schäm*","*skandal*","*wahrheit*","*fair*","unehrlich*","*lüge*")
))

# applying the dictionary 
dfm_btw_pop1 <- dfm(corpus_btw17, dictionary=pop_dict_deu, remove = stopwords("german"), remove_punct=TRUE)
dfm_btw_pop1

dfm_btw_pop2 <- dfm(corpus_btw17, dictionary=pop_dict_deu2, remove = stopwords("german"), remove_punct=TRUE)
dfm_btw_pop2


# share of populist words1
relpop1 <- as.numeric((dfm_btw_pop1[,"populism"])/ntoken(corpus_btw17))*100
relpop1 <- round(relpop1, digits = 3)
relpop1


# share of populist words2
relpop2 <- as.numeric((dfm_btw_pop2[,"people"]+dfm_btw_pop2[,"sovereignty"]+dfm_btw_pop2[,"elites"]+dfm_btw_pop2[,"blame"])/ntoken(corpus_btw17))*100
relpop2 <- round(relpop2, digits = 3)
relpop2


## compare the variants by plotting the results 
party <- as.character(docvars(corpus_btw17, "party"))
plot_relpop <- data.frame(relpop1,relpop2,party)
ggplot(plot_relpop, aes(x = relpop1, y = relpop2)) +
  geom_point() +
  labs(x = "Relative Populist Rhetoric 1", y = "Relative Populist Rhetoric 2") +
  geom_text(aes(label=party),hjust=-0.1, vjust=-0.1)


####
# Sentiment of Lion King 
# Get the [Lion King movie (1994) text](https://www.springfieldspringfield.co.uk/movie_script.php?movie=lion-king-the) and compare the sentiment to Taxi Driver 

# Taxi Driver from disk 
df_taxi <- readtext("U:/QTA Kurs CDSS/data/taxidriver.txt", encoding="UTF-8")
taxi_corp <- corpus(df_taxi)
taxi_sent <- dfm(taxi_corp, dictionary = data_dictionary_LSD2015)
taxi_sent


## Lion King 

## Scraping code 
## Code adapted from Katharina/https://www.r-bloggers.com/mining-game-of-thrones-scripts-with-r/
library(rvest)

nh.films <- c("taxi-driver", "lion-king-the" )
baseurl <- "https://www.springfieldspringfield.co.uk/movie_script.php?movie="
all.scripts <- NULL

for (i in 1:length(nh.films)) {
  url <- paste0(baseurl, nh.films[i])
  webpage <- read_html(url)
  script <- webpage %>% html_node(".scrolling-script-container")
  all.scripts[i] <- html_text(script, trim = TRUE)
}

# convert all.scripts into dataframe
nh <- as.data.frame(all.scripts, stringsAsFactors = FALSE)
counter <- paste0(nh.films)
row.names(nh) <- counter[1:length(nh.films)]
colnames(nh) <- "text"
nh.tibble <-as_tibble(nh)

# convert into corpus
nh.corpus <- corpus(nh)
summary(nh.corpus)

# sentiment 
films_sent <- dfm(nh.corpus, dictionary = data_dictionary_LSD2015)
films_sent

# net tone 
pos <- as.numeric(films_sent[,"positive"]) - as.numeric(films_sent[,"neg_positive"])
neg <- as.numeric(films_sent[,"negative"]) - as.numeric(films_sent[,"neg_negative"])
net_tone <- pos/ntoken(nh.corpus)-neg/ntoken(nh.corpus) 
net_tone


### Exercise readability and lexical diversity 

## EU Speeches (Verena) -> data provided 
# Random sample of English texts: 
# corpus_eu <- corpus(speeches_ep6_cleaned, text_field = "textEN")
# corpus_eu_sample <- corpus_sample(corpus_eu, 100)
# head(summary(corpus_eu_sample))

# Plot readability and lexical diversity against each other, with MPs as labels 

corpus_eu_sample <- readRDS("C:/Users/Dr. J/Desktop/corpus_eu_sample.Rds")
ndoc(corpus_eu_sample)
names(docvars(corpus_eu_sample))

# readability 
read_eu <- textstat_readability(corpus_eu_sample, measure = "ARI")
read_eu

# lexical diversity 
lexdiv_eu <- textstat_lexdiv(dfm(corpus_eu_sample), measure = "K")
lexdiv_eu

div <- lexdiv_eu$K
read <- read_eu$ARI 
MP <- as.character(docvars(corpus_eu_sample, "name"))
plot_lex <- data.frame(div,read, MP)

ggplot(plot_lex, aes(x = div, y = read, label = MP)) +
  geom_point() +
  labs(x = "Lexical Diversity (K)", y = "Readability (ARI)") +
  geom_text(aes(label=MP),hjust=-0.1, vjust=-0.1)


ggplot(plot_lex, aes(x = div, y = read)) +
  geom_point() +
  labs(x = "Lexical Diversity (K)", y = "Readability (ARI)")

