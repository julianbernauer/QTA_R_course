# QTA Paper Populism  
# Using Python from R 
# Sentence retrieval 

# using reticulate 
library(reticulate)

# If you want to work with Python interactively you can call the repl_python() function
repl_python()

# talking Python, import modules 
import codecs
import nltk
import string
import os
import numpy as np
import gensim
from sklearn.metrics.pairwise import cosine_similarity

# Consider Indentation, REPL also seems not to like empty lines 
# or comments between lines 

# What's happening: 
# - this represents any text as a single "doc-embedding"
# - input should be a string
# - text_lower() ensures lowercase
# - nltk.tokenize... to tokenize 
# - removing numbers and punctuation 
# - get the embedding for each word and append it to a list
# - average the embeddings of all the words, getting an overall doc embedding
# - the output is a doc embedding

# preparation 
exclude = set(string.punctuation)

def text_embedding(text):
  text = text.lower()
  text = nltk.tokenize.WordPunctTokenizer().tokenize(text)
  text = [token for token in text if token not in exclude and token.isalpha()]
  doc_embed = []
  for word in text:
    try:
      embed_word = emb_model[word]
      doc_embed.append(embed_word)
    except KeyError:
      continue
  if len(doc_embed)>0:
    avg = [float(sum(col))/len(col) for col in zip(*doc_embed)]
    avg = np.array(avg).reshape(1, -1)
    return avg
  else:
    return "Empty"


# load the pre-trained word embeddings (source: https://fasttext.cc/docs/en/pretrained-vectors.html) 
# takes a while, a few GB 
emb_model = gensim.models.KeyedVectors.load_word2vec_format('C:/DRJB/QTA Analysis/wordembeddings/wiki.de.vec', binary=False)


# core of the exercise: query for similarity with populist key words 
query = "volk elite souverän"

# use the function on the query 
query_emb = text_embedding(query)


# data: 2017 BTW election 
collection_path = "M:/QTA Kurs CDSS/data/btw2017/"

# manifestos, divided in sentences, represented as sentence embeddings
collection = {}

# loop over the folder
for filename in os.listdir(collection_path):
  # open each file, specifying encoding 
  content = codecs.open(collection_path+filename,"r","utf-8").read()
  # split it in sentences
  content = nltk.sent_tokenize(content)
  # represent each sentence in each document as a word-embedding, 
  # which captures the meaning of the sentence
  content = [[sent, text_embedding(sent)] for sent in content if type(text_embedding(sent))!= str]
  collection[filename] = content

# the information retrieval part
for filename,sentences in collection.items():
  # compare the cosine similarity between the embedding of the query and each sentence embedding
  ranking = [[sent, cosine_similarity(query_emb,sent_emb)[0][0]] for sent, sent_emb in sentences]
  # ranking based on the similarity
  ranking.sort(key=lambda x: x[1],reverse=True)
  print (filename)
  # change here for having more sentences as output
  for sent, score in ranking[:1]:
    print (sent, score)
  print (" \n")

# Stop Python session 
exit

