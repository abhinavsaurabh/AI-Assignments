
#importing libraries
import nltk
import numpy as np
#importing WordNet Lemmatizer 
from nltk.stem import WordNetLemmatizer 
import pandas as pd
from nltk.corpus import stopwords

import sklearn
#importing word tokenizer
from nltk.tokenize import word_tokenize

warnings.filterwarnings('ignore')
import string
import warnings
from nltk.stem import PorterStemmer



#importing nltk libraries corpse



#nltk downloading stopwords
nltk.download('stopwords')
#nltk downloading punkt
nltk.download('punkt')

#Ntlk downloads
#nltk downloading wordnet
nltk.download('wordnet')


inplist = []
#stop words from the english
stopWords = set(stopwords.words('english'))

#Using the wordNet Lemmatizer
wordnet_lemmatizer = WordNetLemmatizer()

#Taking user input about their previous knowledge
print("What have you done till now and interests ?\n")  
inp1 = input()

#converting all the inputs into lower letters.
text = inp1.lower()        
for sgn in string.punctuation:    #Further removing the punctuations.
  text= text.replace(sgn, ' ')


#lemmatising the words and storing the in the text
text = wordnet_lemmatizer.lemmatize(text)    

#tokenising the text and making them store in tok1
tok1 = word_tokenize(text)      

#removing the stop words here
for wod in tok1:
    if wod not in stopWords:    
      inplist.append(wod)


#Opening the facts file so that it can store the facts that are generated below by analysing the text.
f = open("facts.txt", 'w')


#list of important keywords
wordlist = ['python','programming','ml','database','advanceprogramming','probability','discreetmaths','cn','electronics','cryptography']

#putting yes and no for main keywords that are required by the program
for key in wordlist:
  if key in inplist:
      f.write("yes('")
      f.write(key)
      f.write("').\n")
  else:
      f.write("no('")
      f.write(key)
      f.write("').\n")

#Asking for artificial intelligence.
inp1 = input("Are you interested in Artificial Intelligence?")
f.write("ai(")
f.write(inp1)
f.write(").\n")

#Asking for Data Engineering.
inp2 = input("Are you interested in Data Engineering?")
f.write("de(")
f.write(inp2)
f.write(").\n")

#Asking for Information Security.
inp3 = input("Are you interested in Information Security?")
f.write("is(")
f.write(inp3)
f.write(").\n")

#Asking for Mobile Computing.
inp4 = input("Are you interested in Mobile Computing?")
f.write("mc(")
f.write(inp4)
f.write(").\n")



f.close()