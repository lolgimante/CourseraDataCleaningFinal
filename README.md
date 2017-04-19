### Introduction

In this repository you will find the files for the last project of Coursera's Data cleaning assigment. It contains 4 files: the code, code book, readme and output data files. The goal is to prepare tidy data that can be used for later analysis.

### Initial data set

I use the data collected from the accelerometers from the Samsung Galaxy S smartphone.

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Assignment

The R script called run_analysis.R does the following:

It merges the training and the test sets and assigns it to new data set called **set**. After that it assigns *features* to column names of **set** and adds additional column with the descriptive activity names and subject ids. 
From this **set** it extracts only the measurements on the mean and standard deviation for each measurement. Because actitivity and subject id collections are not unique (meaning it was registered more than once for the subject), the final part of the script calculates the averages of these features through all the observations of the same activity and subject, and writes it to file **x_subset.txt**.

### Output data

The output data are in the file called *x_subset.txt*. First column of this file contais activity name and subject number in a string formatted as such "{*activityName*}_P{*subjectId*}". First row of this file contains feature names, for which the averages were calculated.
