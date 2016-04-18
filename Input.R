library(stringr)
library(tm)
library(RCurl)
library(quanteda)

#crossmatch <- function(x,y,table){
#  a <-intersect(grep(x,table),grep(y,table))
#  return(a)
#}

#wordstop <- paste(stopwords("english"), collapse = "$|")

#search 4 gram 3 words
fourgram <- function(x){
  x <- word(x,-3,-1)
  x1 <- paste("^",x," ",sep="")
  pastex <- paste("\\b",wordstem(word(x,-3:-1)),"\\w*", sep = "",collapse = " ")
  x2 <- paste("^",pastex,sep = "",collasep="")
  rownums <- grep(paste(x1,x2,sep = "|",collapse = ""),fourgramt, value = T)
  listtxt <- unique(word(rownums,-1))
  return(listtxt)
}

#search 3 gram 2 words
threegram <- function(x){
  x1 <- paste("^",word(x,-2,-1)," ",sep="")
  pastex <- paste("\\b",wordstem(word(x,-3:-1)),"\\w*", sep = "",collapse = " ")
  x2 <- paste("^",word(pastex,-2,-1),sep = "",collasep="")
  x3 <- paste("^",word(pastex,-3,-2),sep = "",collasep="")
  rownums <- grep(paste(x1,x2,x3,sep = "|",collapse = ""),threegramt, value = T)
  listtxt <- unique(word(rownums,-1))
  return(listtxt)
}

#search 2 gram 1 word
twogram <- function(x){
  x1 <- paste("^",word(x,-1)," ",sep="")
  pastex <- paste("\\b",wordstem(word(x,-2:-1)),"\\w*", sep = "",collapse = " ")
  x2 <- paste("^",pastex,sep = "",collasep="")
  x3 <- paste("^",word(pastex,-2),sep = "",collasep="")
  rownums <- grep(paste(x1,x2,x3,sep = "|",collapse = ""),twogramt, value = T)
  listtxt <- unique(word(rownums,-1))
  return(listtxt)
}

#search 4 gram partial 3 words
#parttri <- function(x){
#  pastea <- paste("\\b",wordstem(unlist(strsplit(x," "))),"\\w*",sep = "", collapse = " ")
#  partmatch <- grep(paste(word(pastea,-2,-1),"|",word(pastea,-3,-2),sep = ""),fourgramt, value = T)
#  removesstop <- removeWords(partmatch, c(stopwords("english"),unlist(strsplit(pastea, " "))))
#  trima <- trimws(removesstop)
#  answer <- unique(trima[trima!=""])
#  return(answer)
#}

#search 3 gram partial 2 words
#partbi <- function(x){
#  pastea <- paste("\\b",wordstem(unlist(strsplit(x," "))),"\\w*",sep = "", collapse = " ")
#  partmatch <- grep(paste(word(pastea,-2),"|",word(pastea,-1),sep = ""),threegramt, value = T)
#  removesstop <- removeWords(partmatch, c(stopwords("english"),unlist(strsplit(pastea, " "))))
#  trima <- trimws(removesstop)
#  answer <- unique(trima[trima!=""])
#  return(answer)
#}

bigram <- function(x){
  print("processing2gram")
  listtxt <- twogram(x)
  listtxt <- listtxt[!is.na(listtxt)]
  if(length(listtxt)==0){
    return(rnone[1:5])
  }else{
    listtxt <- listtxt[1:5]
    return(listtxt)
  }
}

trigram <- function(x){
  print("processing3gram")
  listtxt <- threegram(x)
  listtxt <- listtxt[!is.na(listtxt)]
  print(head(listtxt))
  if(length(listtxt)==0){
    bigram(x)
  }else{
    listtxt <- listtxt[1:5]
    return(listtxt)
  }
}

quadgram <- function(x){
  print("processing4gram")
  listtxt <- fourgram(x)
  listtxt <- listtxt[!is.na(listtxt)]
  print(head(listtxt))
  print(length(listtxt))
  if(length(listtxt)==0){
    trigram(x)
  }else{
    listtxt <- listtxt[1:5]
    return(listtxt)
  }
}

#partmatch <- function(x,len){
#  partstem <- paste("\\b",wordstem(unlist(strsplit(x," "))),"\\w*",sep = "", collapse = " ")
#  print(len)
#  switch(len, "2" = threegram(x),"1" = twogram(x))
#}

takeinput <- function(x){
  senlen <- sapply(gregexpr("\\W+",x),length)+1
  x <- gsub("[[:space:]]*$","",x)
  x <- tolower(x)
  x <- removePunctuation(x)
  one <- rnone
  print(x)
  print(senlen)
if  (senlen < 2){
    #2gram 1 word
    answer <- bigram(x)
    return(answer[!is.na(answer)])
  }else if(senlen < 3){
    #3gram 2 words
    answer <- trigram(x)
    return(answer[!is.na(answer)])
  }else{
    #4gram 3 words
    answer <- quadgram(x)
    return(answer[!is.na(answer)])
  }
}