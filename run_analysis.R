## Getting and Cleaning Data Course Project ##
## Set working directory
setwd("C:/Users/xzhan86/Desktop/Coursera/Data science/Course 3 - Getting and cleanning data")

## Download the data file
filename <- "course_project_data.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

## Load training data
setwd("C:/Users/xzhan86/Desktop/Coursera/Data science/Course 3 - Getting and cleanning data/UCI HAR Dataset")
train.data <- read.table("./train/X_train.txt")
train.label <- read.table("./train/y_train.txt")
train.subj <- read.table("./train/subject_train.txt")

## Load test data
test.data <- read.table("./test/X_test.txt")
test.label <- read.table("./test/y_test.txt")
test.subj <- read.table("./test/subject_test.txt")

## Merge training and test datasets, and extract mean() and std() columns only
data.total <- cbind(rbind(train.subj, test.subj), rbind(train.label, test.label), rbind(train.data, test.data))
var.name <- read.table("./features.txt", header=FALSE)
indx <- grepl("mean()|std()", var.name[,2]) & !grepl("Freq", var.name[,2])
data.sub <- data.total[,c(1,2,which(indx == TRUE) + 2)]
names(data.sub) <- c("Subject", "Level", as.vector(var.name[,2][indx]))

## Use descriptive activity names to name the activities in the data set
label <- read.table("./activity_labels.txt")
names(label) <- c("Level", "ActivityLabel")
data.sub2 <- merge(data.sub, label, by = "Level", sort = FALSE)
col.end <- dim(data.sub2)[2]
data.sub2 <- data.sub2[, c(col.end, 1:(col.end-1))]

## Relabel the data set with descriptive variable names
relabel <- function(x){
  x <- sub("^t", "TimeDomain", x)
  x <- sub("^f", "FrequencyDomain", x)
  x <- gsub("\\()", "", x)
  x <- gsub("-", "", x)
  x <- gsub("Acc", "Accelerometer", x)
  x <- gsub("Gyro", "Gyroscope", x)
  x <- gsub("Mag", "Magnitude", x)
  x <- gsub("Freq", "Frequency", x)
  x <- gsub("mean", "Mean", x)
  x <- gsub("std", "StandardDeviation", x)
  return(x)
}

names(data.sub2) <- relabel(names(data.sub2))

## Create a tidy data set with the average of each variable for each activity and each subject
data.tidy <- aggregate(data.sub2[,4:col.end], list(ActivityLabel = data.sub2[,1], Subject = data.sub2[,3]), mean )

## Save the data
setwd("C:/Users/xzhan86/Desktop/Coursera/Data science/Course 3 - Getting and cleanning data/Week 4 course project")
write.table(data.tidy, "./Clean_Data.txt", sep = " ", col.names = TRUE, row.names = FALSE)


