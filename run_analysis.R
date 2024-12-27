setwd("P://R/Coursera/Asn/Getting_cleaning_data/wk4")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "./Dataset.zip")
unzip("Dataset.zip")
setwd("P://R/Coursera/Asn/Getting_cleaning_data/wk4/UCI HAR Dataset")
library("dplyr")

## Assign dataset to variables
feature <- read.table("./features.txt", col.names = c("n", "functions"))
activities <- read.table("./activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("./test/subject_test.txt", col.names = "subject")
subject_train <- read.table("./train/subject_train.txt", col.names = "subject")
x_test <- read.table("./test/X_test.txt", col.names = feature$functions)
x_train <- read.table("./train/X_train.txt", col.names = feature$functions)
y_test <- read.table("./test/y_test.txt", col.names = "code")
y_train <- read.table("./train/y_train.txt", col.names = "code")

## Merges the training and the test sets to create one data set.
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged <- cbind(Subject, Y, X)

## Extracts only the measurements on the mean and standard deviation for each measurement. 
TidyData <- Merged %>% select(subject, code, contains("mean"), contains("std"))

## Uses descriptive activity names to name the activities in the data set
TidyData$code <- activities[TidyData$code ,2]

## Appropriately labels the data set with descriptive variable names.
names(TidyData)[2] = "activity"
names(TidyData) <- gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData) <- gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData) <- gsub("^t", "Time", names(TidyData))
names(TidyData) <- gsub("Mag", "Magnitude", names(TidyData))
names(TidyData) <- gsub("^f", "Frequency", names(TidyData))
names(TidyData) <- gsub("BodyBody", "Body", names(TidyData))
names(TidyData) <- gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)

names(TidyData) <- gsub("mean", "Mean", names(TidyData))
names(TidyData) <- gsub("gravity", "Gravity", names(TidyData))
names(TidyData) <- gsub("angle", "Angle", names(TidyData))

## From the data set in step 4, creates a second, independent tidy data set with 
## the average of each variable for each activity and each subject.
CalData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(mean)
write.table(CalData, "Final.txt", row.names = FALSE)




