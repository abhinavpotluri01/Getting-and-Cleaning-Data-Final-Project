library(dplyr)
fileName <- "UCI HAR Dataset.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, fileName, method="curl")
unzip(fileName)
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header= FALSE)
names(activityLabels) <- c("code", "activity")
features <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
names(features) <- c("number","functions")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
names(subjectTest) <- "subject"
xTest <- read.table("UCI Har Dataset/test/X_test.txt", header = FALSE)
names(xTest) <- features$functions
yTest <- read.table("UCI Har Dataset/test/y_test.txt", header = FALSE)
names(yTest) <- "code"
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
names(subjectTrain) <- "subject"
xTrain <- read.table("UCI Har Dataset/train/X_train.txt", header = FALSE)
names(xTrain) <- features$functions
yTrain <- read.table("UCI Har Dataset/train/y_train.txt", header = FALSE)
names(yTrain) <- "code"
x <- rbind(xTrain, xTest)
y <- rbind(yTrain, yTest)
subject <- rbind(subjectTrain, subjectTest)
mergedData <- cbind(subject, y, x)
tidyData <- mergedData %>% select(subject, activity, contains("mean"), contains("std"))
tidyData$code <- activityLabels[tidyData$code, 2]
names(tidyData)[2] = "activity"
names(tidyData)<-gsub("Acc", "accelerometer", names(tidyData))
names(tidyData)<-gsub("Gyro", "gyroscope", names(tidyData))
names(tidyData)<-gsub("BodyBody", "body", names(tidyData))
names(tidyData)<-gsub("Mag", "magnitude", names(tidyData))
names(tidyData)<-gsub("^t", "time", names(tidyData))
names(tidyData)<-gsub("^f", "frequency", names(tidyData))
names(tidyData)<-gsub("tBody", "time body", names(tidyData))
names(tidyData)<-gsub("-mean()", "mean", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("-std()", "standard deviation", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("-freq()", "frequency", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("angle", "angle", names(tidyData))
averagesData <- tidyData %>% group_by(subject, activity) %>% summarise_all(funs(mean))
write.table(averagesData, "averagesData.txt", row.name=FALSE)
