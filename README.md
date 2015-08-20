### README
This project has been divided into five work items

1 - Merges the training and the test sets to create one data set.

2 - Extracts only the measurements on the mean and standard deviation for each measurement. 

3 - Uses descriptive activity names to name the activities in the data set

4 - Appropriately labels the data set with descriptive variable names. 

5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



#####1 - Merges the training and the test sets to create one data set.

There are two files train/X_train.txt and test/X_test.txt. X_train has dimensions 7352x561 and X_text has dimensions of 2947x561. The columns of both the files are given in features.txt. Reading the files using read.table function. Since the number of columns are same we can merge the datasets using rbind. Assign  Column names for the dataset as read from features.txt file.


#####2 - Extracts only the measurements on the mean and standard deviation for each measurement.

On the merged data set, first check the columns which have either mean() or std() in its name. Take the seubset of the merged data set with these columns. Using cbind, add the columns for activity and subject. 


#####3 - Uses descriptive activity names to name the activities in the data set

Activity names are given in activity_labels.txt. Using mutate function change the columns to the activity label and then delete the original column which has integers.


#####4 - Appropriately labels the data set with descriptive variable names.

The column names are short form and in order to make it descriptive,I am replacing Acc by Accelerator, Mag by Magnitude, Gyro by Gyroscopic, iqr by interQuantileRange, arCoeff by AutorregresionCoefficient and BodyBody by Body.


#####5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

As per the definition of tidy data, each column should represent a variable and each row should represent a observation. In this dataset, the variables which are shortlisted for mean and std are already the columns of the data set. Further two variables are added as columns are subject and the activity. In order to get this tidy data, first the dataset is grouped by subject and activity. Then it is sumarrized for every variable with mean function. The dimension of tidy data is 180x68. 
