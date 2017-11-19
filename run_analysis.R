setwd("~/GitHub/GettingAndCleaningData.git/UCI HAR Dataset/")

dataDir <- getwd()

# Read file of features: signals and estimation variables 
pathFeatures <- paste(dataDir, "/features.txt", sep="")
features <- read.table(pathFeatures)[,"V2"]
# Subset of features: filter by the mean and standard deviation variables
filterFeatures <- sort(union(grep("mean\\(\\)", features), grep("std\\(\\)", features)))
# Features: clean parenthesis
features <- gsub("\\)", "", gsub("\\(", "", features))

#============================================================================

# Read file of measurements: Tests and Training
testSet <- read.table(file=paste(dataDir, "/test/X_test.txt", sep=""),col.names=features)
testSet <- testSet[,filterFeatures]

trainSet <- read.table(file=paste(dataDir, "/train/X_train.txt", sep=""),col.names=features)
trainSet <- trainSet[,filterFeatures]

dataSet <- rbind(testSet,trainSet)

# Read file of subjects: Tests and Training
pathSubjectTest <- paste(dataDir, "/test/subject_test.txt", sep="")
pathSubjectTrain <- paste(dataDir, "/train/subject_train.txt", sep="")
subject <- c(read.table(pathSubjectTest)[,"V1"], read.table(pathSubjectTrain)[,"V1"])

dataSet <- cbind(dataSet,subject)

# Read file of activity labels
pathActivity <- paste(dataDir, "/activity_labels.txt", sep="")
activity <- read.table(pathActivity)[,"V2"]
# Read file of test labels: Test and Training
pathTest_y <- paste(dataDir, "/test/y_test.txt", sep="")
pathTrain_y <- paste(dataDir, "/train/y_train.txt", sep="")
data_y <- c(read.table(pathTest_y)[,"V1"], read.table(pathTrain_y)[,"V1"])
activity <- activity[data_y]

# Data measurements by subject and activity
dataSet <- cbind(dataSet,activity)

#============================================================================

# Calculate average the average of each variable for each activity and each subject
dataSet_x <- dataSet[,seq(1, length(names(dataSet)) - 2)]

# Create a list of average for activity and subject
dataSet_by <- by(dataSet_x,paste(dataSet$subject, dataSet$activity, sep="_"), FUN=colMeans)

# Use do.call function to create a data.frame with mesurements by activity and subject
tidyData <- do.call(rbind, dataSet_by)

#============================================================================
# Write tidy data
write.table(tidyData, "~/GitHub/GettingAndCleaningData.git/tidyDataHumanActivity.txt")
