#necessary libraries
library(dplyr)
library(data.table)

#Reading the training data in and modifying their column names
subTrain <- read.table("train/subject_train.txt")
xTrain <- read.table("train/X_train.txt")
feature_lbls <- read.table("features.txt")
yTrain <- read.table("train/y_train.txt")

#Once read in, the columns of x contained no column names. Adding column names 
#from the features.txt.
colnames(xTrain)<- feature_lbls$V2
colnames(yTrain)[1]<-"activity_labels"
colnames(subTrain)[1]<-"participant.number"
yTrain$activity_labels <- factor(yTrain$activity_labels,levels = c("walking","walking.upstairs","walking_downstairs", "sitting","standing","laying"))

#Adding the activity_labels to xTrain from yTrain, along with the participant
#number in order to merge the split training data
setDT(xTrain)
xTrain[, "activity_labels":=yTrain]
xTrain[, "participant.number":=subTrain$participant.number]

##Applying the above to the test Data

#Reading the test data in and modifying their column names
subTest <- read.table("test/subject_test.txt")
xTest <- read.table("test/X_test.txt")
yTest <- read.table("test/y_test.txt")

#Once read in, the columns of x contained no column names. Adding column names 
#from the features.txt.
colnames(xTest)<- feature_lbls$V2
colnames(yTest)[1]<-"activity_labels"
colnames(subTest)[1]<-"participant.number"

#Applying named factors to the activity levels. This makes further analysis
#far easier in the long run.
yTest$activity_labels <- factor(yTest$activity_labels,labels = c("walking","walking.upstairs","walking_downstairs", "sitting","standing","laying"))

#Adding the activity_labels to xTrain from yTrain, along with the participant
#number in order to merge the split training data

setDT(xTest)
xTest[, "activity_labels":=yTest]
xTest[, "participant.number":=subTest$participant.number]

#combining both the train and test datasets using rbindlist.
combo <- rbindlist(list(xTrain,xTest))

#Here, I hope to extract the columns in combo that contains the mean and 
# standard deviation. Since these columns had "mean()" and "std()" in their
# column names, I chose to look for these using regular expressions.
namesC <- colnames(combo)
indices<-  grep("(mean\\(\\))|(std\\(\\))", namesC)

#Grep returns the column indices where the desired columns are found. I extracted
# them out with the data.table package. After that I added the 
# activity_labels and the participant.number as well. The resulting data table is
# one that has the extracted data.
#http://stackoverflow.com/questions/28094645/select-subset-of-columns-in-data-table-r
temp <- combo[,indices,with=F]
temp[,c("activity_labels","participant.number" ):=c(combo[,"activity_labels", with=F], combo[,"participant.number", with=F])]

#Here, I will find the averages of all of the activities based on the 
#for every activity label and for every participant. To do so, I made
#the participant.number to be a factor and used group_by on these
#variables
temp$participant.number <- factor(temp$participant.number)
tempGuess <- group_by(temp, activity_labels, participant.number)
output <- summarise_all(.tbl =  tempGuess, .funs = "mean")

#Writing the output to a text file.
write.table(output, file = "TidiedHumanActivity.txt", row.names = F)
