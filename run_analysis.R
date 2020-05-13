filename <- "Coursera_DS3_Final.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}


#there are 30 subjects denoted by number in the subject_ files
#there are six activities denoted by the y_train files

#data files we want:
activities <- read.table("./UCI HAR Dataset/activity_labels.txt") 
features <- read.table("./UCI HAR Dataset/features.txt") 
training_subject<- read.table("./UCI HAR Dataset/train/subject_train.txt",stringsAsFactors = F)
training_set<- read.table("./UCI HAR Dataset/train/X_train.txt")
training_label<- read.table("./UCI HAR Dataset/train/y_train.txt",stringsAsFactors = F)
test_subject<- read.table("./UCI HAR Dataset/test/subject_test.txt",stringsAsFactors = F)
test_set<- read.table("./UCI HAR Dataset/test/X_test.txt")
test_label<- read.table("./UCI HAR Dataset/test/y_test.txt",stringsAsFactors = F)


#Finding columns that contain mean or std
meancol <- grep("mean",features[,2]) 
stdcol <- grep("std",features[,2])
col_we_want <- sort(c(meancol,stdcol)) #all the columns that match critera of meancol or stdcol
features_we_want <- features[col_we_want,] # all the feature names we want to look at


## Organizing training tables 

training_set_data <- training_set[,features_we_want[,1]] #grabbing only the data with mean or std
colnames(training_set_data) <- features_we_want[,2] #renaming columns to match their given features
training_set_data$subject <- training_subject[,1] #creating a subject column
training_set_data$activities <- training_label[,1] #creating an activites column

## Organizing test tables

test_set_data <- test_set[,features_we_want[,1]] #grabbing only the data with mean or std
colnames(test_set_data) <- features_we_want[,2] #renaming columns to match their given features
test_set_data$subject <- test_subject[,1] #creating a subject column
test_set_data$activities <- test_label[,1] #creating an activites column


## combining test and training together
combined_data_set <- rbind(training_set_data,test_set_data) #combines data
ordered_data <- arrange(combined_data_set,subject) #arrange by subject for neatness

#descriptive names for activities
ordered_data$activities <- activities[ordered_data$activities,2] 

#descriptive names for features
names(ordered_data) <- gsub("Freq", "Frequency", names(ordered_data))
names(ordered_data) <- gsub("Acc", "Acceleration", names(ordered_data))
names(ordered_data) <- gsub("^t", "Time", names(ordered_data))
names(ordered_data) <- gsub("^f", "Frequency", names(ordered_data))
names(ordered_data) <- gsub("BodyBody", "Body", names(ordered_data))
names(ordered_data) <- gsub("mean", "Mean", names(ordered_data))
names(ordered_data) <- gsub("std", "Std", names(ordered_data))
names(ordered_data) <- gsub("Mag", "Magnitude", names(ordered_data))

## analysis by sub groupings:
FinalData <- ordered_data %>%
  group_by(subject,activities) %>% #group data by subject then by activity
  summarise_all(mean) #take the mean of our variables by subject, then by activities
FinalData

write.table(FinalData,file="final_data.txt")
