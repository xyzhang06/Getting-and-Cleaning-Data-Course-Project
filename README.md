# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data. The R script, called as run_analysis.R, does the following:

1. Download the data sets from the data source if it does not exist in the working directory.
2. Load both the train and test data sets, merge both data sets, and extract only the measurements on the mean and standard deviation.
3. Load the activity and subject data for each data set, and merge these columns with the dataset from step 2
4. Rename the column names by using descriptive activity names.
5. Creates a tidy data set with the average value of each variable for each subject and each activity.

The tidy data result is in the file Clean_Data.txt.