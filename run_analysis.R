## 
## Peer-graded Assignment: Getting and Cleaning Data Course Project
## Coursera, Johns Hopkins University
## Data Science: Foundations Using R
##
## This script is part of the peer-graded coursework
##
## Please consult readme.md and codebook.md for more information
##
##
## Loading libraries
library(tidyverse)

## Step 1: Merges the training and the test sets to create one data set.
##
## Loading data:
## Data for this assignment is provided in six files in two subfolders
## (test and train) in UCI HAR Dataset folder of this project.

test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_X <- read.table("UCI HAR Dataset/test/X_test.txt")
test_Y <- read.table("UCI HAR Dataset/test/y_test.txt")

train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_X <- read.table("UCI HAR Dataset/train/X_train.txt")
train_Y <- read.table("UCI HAR Dataset/train/y_train.txt")

## Creating one dataset:
## cbinding within test and train sets, then rbinding results into one df.
test <- 
    test_subject %>%
    cbind(test_Y) %>%
    cbind(test_X)

train <- 
    train_subject %>%
    cbind(train_Y) %>%
    cbind(train_X)

dset <- train %>%
    rbind(test)

## Step 2: Extracts only the measurements on the mean and standard deviation
##         for each measurement
##
## Feature names are contained in features.txt
features <- read.table("UCI HAR Dataset/features.txt")

## Assigning meaningful variable names to features
names(features) <- c("feature_index", "feature_name")

## Subseting to identify features with mean() and std(), based on description
## in file UCI HAR Dataset/features_info.txt.
## I am not including variables on meanFreq() and angle() because my
## undearstanding is that only variables that include mean() and std()
## should be included.
features_sub <-
    features %>%
    filter(str_detect(feature_name, "mean()|std()"),
           !str_detect(feature_name, "-meanFreq()"))

## Since datasets are merged, indexes of feature variables are shifted by 2
dset2 <- dset[, c(1, 2, features_sub$feature_index + 2)]

## Step 3: Uses descriptive acitivity names to name the activities in the
##         dataset.
##
## List of values for activities is available in file 
## UCI HAR Dataset/activity_labels.txt.
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

## Assigning meaningful variable names to activities:
names(activities) <- c("activity_code", "activity_name")

## According to UCI HAR Dataset/README.txt, data labels are supplied in files
## y_train.txt and y_test.txt. Those files are represented by the second
## column of the dataset, V1.1
dset3 <-
    dset2 %>%
    inner_join(activities, by = c("V1.1" = "activity_code")) %>%
    mutate(V1.1 = as.character(activity_name)) %>%
    select(-activity_name)

## Step 4: Appropriately labels the data set with descriptive variable names
names(dset3) <- c("subject", "activity", as.character(features_sub$feature_name))

## Step 5: From the data in step 4 create a second, independent tidy data set
##         with the average for each variable for each activity and each subject
##
## I would argue that the present condition of dset3 is tidy, if very wide.
## Alternatively, one could view each measurement as a seperate observation.
## That would result in a very narrow and long data set. Still, this could be
## a practical step.
##
## Variable names will be mutated to avoid automatic variable renaming during
## export via write.table() and to make averages distinct from input variables.
dset4 <-
    dset3 %>%
    gather(key = "variable", value = "value", -(subject:activity)) %>%  ## narrow
    mutate(variable = str_remove_all(variable, fixed("()")),
           variable = str_replace_all(variable, fixed("-"), "_"),
           variable = paste0(variable, "_average")) %>%
    group_by(subject, activity, variable) %>% 
    summarise(mean_value = mean(value)) %>%
    spread(key = variable, value = mean_value) ## wide againg

## Gather creates a narrow data set, wich is practical for summarizing,
## and spread returns the summarized data set to a wide form. I think
## that wide form is easier for human consumption.

## Final step: Create submition txt file
write.table(dset4, file = "tidy_data_set.txt", row.names = FALSE)


## To view the exported data set:
tidy_data_set <- read.table("tidy_data_set.txt", header = TRUE)
View(tidy_data_set)
