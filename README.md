# Getting and Cleaning Data - Peer Assessment Project

Here you can find the full description of data:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

And the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

In the run_analysis.R script, these are my functions:

**getData:**
Expects two kinds of string parameter: 
* By "test" parameter, the function reads the appropriate data in test folder. 
* By "train" parameter, the function reads the appropriate data in train folder.

**mergeDataset:**
This function calls the getData function with 2 parameters ("test" and "train") and combines the two dataset read in the above functions, by rows.Further, proper name is given to the columns and dataset is returned.

**getActivityLabels:**
This function reads and returns the data in the file "activity_labels.txt".

**mergeActivityLabels:**
This function runs the getActivityLabels function and merge the result set with the main dataset.

**cleanData:**
This function creates a clean data set with average of each variable for each activity and each subject and writes it to a file named "cleanData.txt"
