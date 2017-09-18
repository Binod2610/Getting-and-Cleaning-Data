Getting and Cleaning Data:
==========================
Introduction
------------
This repo contains assignment for "Getting and Cleaning data"

About given raw data
------------------
Values of Varible Activity consist of data from “Y_train.txt” and “Y_test.txt”
values of Varible Subject consist of data from “subject_train.txt” and subject_test.txt"
Values of Varibles Features consist of data from “X_train.txt” and “X_test.txt”
Names of Varibles Features come from “features.txt”
levels of Varible Activity come from “activity_labels.txt”

So we will use Activity, Subject and Features as part of descriptive variable names for data in data frame.

About the script and the tidy dataset
-------------------------------------
The script "run_analysis.R" which i have created which will merge the test and training sets together.


After merging testing and training, labels have been added and only columns that have to do with mean and standard deviation are kept.

Then we modified ActivityId column with descriptive information

Lastly, the script will create a tidy data set containing the means of all the columns per test subject and per activity.
This tidy dataset will be written to a file called TidyData.txt

About the Code Book
-------------------
The CodeBook.md file explains the transformations performed and the resulting data and variables.

