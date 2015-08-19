#Load dplyr package
library(dplyr)
#Read all the files, which is trainset and testset and features names, 
#subject and y (activity) are read for train and test data
trainSet <- read.table("UCI HAR Dataset/train/X_train.txt")
testSet <- read.table("UCI HAR Dataset/test/X_test.txt") 
features <- read.table("UCI HAR Dataset/features.txt")
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
activityLabel <- read.table("UCI HAR Dataset/activity_labels.txt")

# Assign names for teainset and test set using features
names(trainSet) <- features[,2]
names(testSet) <- features[,2]

# Merge the data set using row bind
mergeSet <- rbind(trainSet,testSet)

# Shortlist only those colums which has mean() and std(). 
#create a subset which has these shortlisted columns
#Remove all columns which has meanFreq.
shorlistedCol <- grepl("mean()|std()", names(mergeSet))
selectSet <- mergeSet[shorlistedCol]
selectSet <- selectSet[!grepl("meanFreq",names(selectSet))]

# Merge y and subject dataset
mergeY <- rbind(yTrain,yTest)
names(mergeY) <-"y"

mergeSubject <- rbind(subjectTrain,subjectTest)
names(mergeSubject) <- "subject"

#Merge y and subject into the dataset
selectSet <- cbind(selectSet,mergeY)
selectSet <- cbind(selectSet,mergeSubject)

# In order to make the descriptive activity name, 
#using mutate, map the activity number into the description. 
#e.g. 1 maps to WALKING, 2 WALKING_UPSTAIRS and so on. 
# Remove the original y column
selectSet <- mutate(selectSet,activityLabel = activityLabel[y,2])
selectSet <- select(selectSet,-y)

# In order to make the descriptive variable name change Acc to Accelerator,
# Gyro to Gyroscopic, Mag to Magnitude, iqr to interQuantileRange,
# arCoeff to AutorregresionCoefficient and BodyBody to Body
varLable <- names(selectSet)

varLable <- gsub("Acc","Accelerator",varLable)
varLable <- gsub("Mag","Magnitude",varLable)
varLable <- gsub("Gyro","Gyroscopic",varLable)
varLable <- gsub("iqr","interQuantileRange",varLable)
varLable <- gsub("arCoeff","AutorregresionCoefficient",varLable)
varLable <- gsub("BodyBody","Body",varLable)

names(selectSet) <- varLable

# group by subect and activity. Create tidy set by summarizing each columns 
# other than subject and activity and calculate mean of each column
selectSet <- group_by(selectSet,subject,activityLabel)
tidySet <- summarise_each(selectSet,funs(mean))

# Write into the text file
write.table(tidySet,"tidySet.txt",row.name=FALSE)
