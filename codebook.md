# Tidy data - codebook

This document explains variables in tidy_data_set.txt, 
which is output data set of the peer graded coursework
assignment for Getting and Cleaning data course.

## Variables

**subject**   int     
  Identification code for the subject - person whose activites
  have been measured.

**activity**  factor with 6 levels
  Descriptive label of measured activites.
  Levels: "LAYING", "SITTING", "STANDING", "WALKING",  
          "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS"

### Other variables

There is 66 more variables in the dataset that represent averages of
measured features. Their names are constructed as specified in 
UCI HAR Dataset/features_info.txt .

Each of these variables also has "-average" suffix to denote that they
have been averaged over subjects and activities.

All these variables are numeric.
