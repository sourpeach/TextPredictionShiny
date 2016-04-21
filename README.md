# Text Prediction Shiny App 
The shiny app is a simple app which takes in a phrase or word and gives 5 predictions to the next most likely word.
- Example: You type -> "You mean the" Predictions -> "world, one, whole, word, stuff"

The shiny app can be access at <https://sourpeach.shinyapps.io/TextPredictionShiny/>

# The Data
- The raw data were taken from feeds in twitter, blogs, and news found online. 
- The  data were then cleaned of any emoji, symbols or non-english words.
- They were then sampled at 70% of the original data and tokenized from 1 to 4 grams. 
- The  tokens were shaved of frequencies occuring only once.
- The Ngrams were then further shaved of words with only two letters.
- The resulting data was the collection of phrases or tokens in 1 to 4 grams decscending in frequency of occurence.

# The Prediction Model
- The prediction model in "Input.R" is a model previously develped in another project and refined further to increase the accuracy of the prediction.
- The model takes in a phrase and predicts the last words using 4 gram to 1 gram. Where the last 3 word of a phrase is taken if the user enters more than 3 words and match the 3 words to the beginning of 4 grams and output the last word as the prediction. 
- During testing some refinining were made to increase accuracy such as stemming the user input words such as removing "s" from a word *example: "helps" -> "help*.
- Another step was to find words through association such as finding two words not at the beginning but anywhere in an Ngram and output the remaining word from the Ngram match as an prediction.

# The App
Files are include in server.R, ui.R and global.R
- global.R - calls the shiny package and the stored data to be loaded
- server.R - calls on the Input.R to predict the words necessary
- ui.R - takes user input in a text box then outputs the prediction once the submit button is pressed
