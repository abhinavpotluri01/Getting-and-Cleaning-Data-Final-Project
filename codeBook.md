1. Downloaded the dataset and extracted it under the folder called UCI HAR Dataset

2. Assigned each data to variables
   - activityLabels <- activity_labels.txt 
      The activities performed during the experiment and its labels
   - features <- features.txt
     The features  for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
   - subjectTest <- test/subject_test.txt 
     This contains test data of the volunteer test subjects
   - xTest <- test/X_test.txt
     This contains recorded features test data
   - yTest <- test/y_test.txt 
     This contains test data of the activities’ code labels
   - subjectTrain <- test/subject_train.txt 
     This contains train data of the volunteer subjects
   - xTrain <- test/X_train.txt 
     This contains recorded features train data
   - yTrain <- test/y_train.txt 
     This contains train data of activities’code labels

3. Merged the training and the test sets to create one data set
   - x was created by merging xTrain and xTest using rbind()
   - y was created by merging yTrain and yTest using rbind()
   - subject was created by merging subjectTrain and subjectTest using rbind()
   - mergedData was created by merging subject, y and x using cbind()

4. Extracted only the mean and standard deviation for each measurement only
   - tidyData was created by subsetting mergedData by selecting only these columns: subject, code, and the measurements on the mean and standard deviation for each measurement

5. Used descriptive activity names to name the activities in the data set
   - Entire numbers in code column of the TidyData replaced with corresponding activity taken from second column of the activities variable

6. Appropriately labeled the data set with descriptive variable names
   - code column in tidyData renamed activities
   - Acc in column’s name replaced by accelerometer
   - Gyro in column’s name replaced by gyroscope
   - BodyBody in column’s name replaced by body
   - Mag in column’s name replaced by magnitude
   - All columns starting with "f" in column’s name were replaced by frequency
   - All columns starting with "t" in column’s name were replaced by time

7. From the data set in step 4, a second, independent tidy data set with the average of each variable for each activity and each subject was created called averagesData.
   - averagesData was created by sumarizing tidyData by taking the means of each variable for each activity and each subject, and after, it was grouped by subject and activity. 
   - averagesData.txt was created from averagesData using write.table. 
