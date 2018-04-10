train <- read.csv("F:/Introduction to ML (Data Camp) & datasets/Quora/train.csv", stringsAsFactors=FALSE)
View(train)
test <- read.csv("F:/Introduction to ML (Data Camp) & datasets/Quora/test.csv", stringsAsFactors=FALSE)
View(test)
quora<-head(train)
str(quora)
library(rpart)
library(ggplot2)
library(dplyr)
install.packages("Rstem")
library(Rstem)
strsplit(train$question1, split = " ")
q1<-strsplit(train$question1, split = " ")
q2<-strsplit(train$question2, split = " ")
wordStem(q1[1])
wordStem(q2[1])
for (i in 1:6) {
  wordStem(q1[[i]])
}
for (i in 1:6) {
  wordStem(q2[[i]])
}
train$Q1<-q1
train$Q2<-q2
str(train)
install.packages("randomForest")
library(randomForest)
train <- data.frame(train,Q1=unlist(train$Q1),Q2=unlist(train$Q2),qid1=train$qid1,qid2=train$qid2,id=train$id,is_duplicate=train$is_duplicate)
quora1<-randomForest(as.factor(is_duplicate)~Q1 + Q2 + id, data=train, importance=TRUE)
my_prediction<-predict(quora1,test)
my_solution<-data.frame(test_id=test$test_id,is_duplicate=my_prediction)
write.csv(my_solution, file = "my_solution.csv", row.names = FALSE)