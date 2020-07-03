# Tidy data
-----------------------------------

This repository contains a peer graded assignment for
Getting and Clening Data course project.

The course is part of Data Science: Foundations Using R
specialization by Coursera / Johns Hopkins University

-----------------------------------

## Overview

Input data for this project is available in subfolder UCI HAR Dataset, including
a descriptive readme.txt, and feature lists and descriptions.

All transformations performed on the data are contained in run_analysis.R, with
detailed comments.

The goal of this assignment is to transform supplied data in order to create a
new, tidy, data set.

The final data set is available in tidy_data_set.txt. To view this data set it is
best to create a local copy of this repository, open it in RStudio, and then run
```R
tidy_data_set <- read.table("tidy_data_set.txt", header = TRUE)
View(tidy_data_set)
```