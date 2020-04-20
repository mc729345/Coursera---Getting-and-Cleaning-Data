CodeBook

This document summarizes the steps taken by the run_analysis.R script, in order to organize the source data into a new tidy dataset.

1. Dataset downloaded from URL into folder UCI HAR Dataset  
2. Data from separate files read into variables
  activities <- activity_labels.txt
    List of activities performed while respective measurements were taken, along with codes/labels
  features <- features.txt
    The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
  subject_train <- subject_train.txt
    Training data from 21 participants
  y_train <- Y_train.txt
    Training data of activities' codes/labels
  x_train <- X_train.txt
    Recorded features training data
  subject_test <- subject_test.txt
    Test data from 9 participants
  y_test <- Y_test.txt
    Test data of activities' codes/labels
  x_test <- X_test.txt
    Recorded features test data
3. rbind function used to combine training/test data for subjects, X, and Y
4. Unified data set (data_all) created from subject_all, y_all, x_all created in step #3
5. Extracted mean and standard deviation data using select function on data_all
6. Corresponding activity labels and descriptive variable names applied to data_all
7. A second tidy dataset (FinalData.txt) is made from data_all with the average of each variable, grouped by subject and activity. 
  
  
