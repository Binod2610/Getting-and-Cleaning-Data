###Load required packages
library(dplyr)
library(data.table)
library(tidyr)
#Set Working Directory

setwd("C:\\Users\\Vasishtha Prasad\\Desktop\\DataScience\\Getting and Cleaning Data\\Week4\\getdata%2Fprojectfiles%2FUCI HAR Dataset\\UCI HAR Dataset\\")



filesPath <- "C:\\Users\\Vasishtha Prasad\\Desktop\\DataScience\\Getting and Cleaning Data\\Week4\\getdata%2Fprojectfiles%2FUCI HAR Dataset\\UCI HAR Dataset"

##Reading Files:

# Read SubjectTrain and SubjectTest table data
subjectTrainData <- read.table(file.path(filesPath, "train", "subject_train.txt"))
subjectTestData  <- read.table(file.path(filesPath, "test" , "subject_test.txt" ))

# Read activity files data
activityTrainData <- read.table(file.path(filesPath, "train", "Y_train.txt"))
activityTestData  <- read.table(file.path(filesPath, "test" , "Y_test.txt" ))

#Read data files data
trainData <- read.table(file.path(filesPath, "train", "X_train.txt" ))
testData  <- read.table(file.path(filesPath, "test" , "X_test.txt" ))

#Read features data
features <- read.table(file.path(filesPath,"features.txt"))

#Read activity labels
activityLabels <- read.table(file.path(filesPath,"activity_labels.txt"))

## 4.Appropriately labels the data set with descriptive variable names.
##Assigning column names

colnames(trainData) <- features[,2] 
colnames(activityTrainData) <-"activityId"
colnames(subjectTrainData) <- "subjectId"

colnames(testData) <- features[,2] 
colnames(activityTestData) <- "activityId"
colnames(subjectTestData) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

## 1.Merge the training and the test data.

allTrainData <- cbind(activityTrainData, subjectTrainData, trainData)
allTestData <- cbind(activityTestData, subjectTestData, testData)

#combine the DATA training and test files
dataTable <- rbind(allTrainData, allTestData)

## 2.Extracts only the measurements on the mean and standard deviation for each measurement.

#Read column names
colNames <- colnames(dataTable)

#Create vector for defining ID, mean and standard deviation
mean_and_std <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
                 )
#Making nessesary subset from setAllInOne
setForMeanAndStd <- dataTable[ , mean_and_std == TRUE]

TidyData <- aggregate(. ~subjectId + activityId, setForMeanAndStd, mean)
TidyData <- TidyData[order(TidyData$subjectId, TidyData$activityId),]

## 3.Uses descriptive activity names to name the activities in the data set
for (i in 1:180){
  if (TidyData$"activityId"[i] == "1") {TidyData$"activityId"[i] <-  "WALKING"}
  if (TidyData$"activityId"[i] == "2") {TidyData$"activityId"[i] <-  "WALKING_UPSTAIRS"}
  if (TidyData$"activityId"[i] == "3") {TidyData$"activityId"[i] <-  "WALKING_DOWNSTAIRS"}
  if (TidyData$"activityId"[i] == "4") {TidyData$"activityId"[i] <-  "SITTING"}
  if (TidyData$"activityId"[i] == "5") {TidyData$"activityId"[i] <-  "STANDING"}
  if (TidyData$"activityId"[i] == "6") {TidyData$"activityId"[i] <-  "LAYING"}
}


## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#write to text file on disk
write.table(TidyData, "TidyData.txt", row.name=FALSE)
