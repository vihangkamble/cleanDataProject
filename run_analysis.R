library(dplyr)
trainSet <- read.table("UCI HAR Dataset/train/X_train.txt")

testSet <- read.table("UCI HAR Dataset/test/X_test.txt") 
features <- read.table("UCI HAR Dataset/features.txt")
names(trainSet) <- features[,2]
names(testSet) <- features[,2]

mergeSet <- rbind(trainSet,testSet)
shorlistedCol <- grepl("mean()|std()", names(mergeSet))
selectSet <- mergeSet[shorlistedCol]
selectSet <- selectSet[!grepl("meanFreq",names(selectSet))]



yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
mergeY <- rbind(yTrain,yTest)
names(mergeY) <-"y"
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
mergeSubject <- rbind(subjectTrain,subjectTest)
names(mergeSubject) <- "subject"



selectSet <- cbind(selectSet,mergeY)
selectSet <- cbind(selectSet,mergeSubject)

selectSet <- mutate(selectSet,activityLabel = activityLabel[y,2])
selectSet <- select(selectSet,-y)

activityLabel <- read.table("UCI HAR Dataset/activity_labels.txt")

varLable <- names(selectSet)

varLable <- gsub("Acc","Accelerator",varLable)
varLable <- gsub("Mag","Magnitude",varLable)
varLable <- gsub("Gyro","Gyroscopic",varLable)
varLable <- gsub("iqr","interQuantileRange",varLable)
varLable <- gsub("arCoeff","AutorregresionCoefficient",varLable)
varLable <- gsub("BodyBody","Body",varLable)

names(selectSet) <- varLable

selectSet <- group_by(selectSet,subject,activityLabel)
tidySet <- summarise_each(selectSet,funs(mean))

