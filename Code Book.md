# Code Book

## 1: Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset

## 2: Read the data
activities: Activity ID and corresponding name of activity
features: Feature ID and corresponding name of feature
training_subject: Subject ID for those in training group
training_set: values of variables in training
training_label: activity IDs in training group 
test_subject: Subject ID for those in test group
test_set: values of variables in test
test_label: activity IDs in test group 

## 3: Extracts only the measurements on the mean and standard deviation for each measurement
From the test table and training table we select only those features that contain the words "mean" or "std" in them using the grep() function

## 4: Merges the training and the test sets to create one data set
Combined_data_set (10299 rows, 81 column) is created by merging training_set_data and test_set_data using rbind() function

## 5: Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the ordered_data replaced with corresponding activity taken from second column of the activities variable

## 6: Appropriately labels the data set with descriptive features names
All Freq in column's name replaced by frequency
All Acc in column’s name replaced by Accelleration
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time

## 7: From the data set created at the end of the 4th step, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
