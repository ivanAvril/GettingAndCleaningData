# CodeBook

The aim of this code is to build a data file with key information of training in a group of 30 volunteers. The code uses different input files measuring the performance for each person in six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

The output file describes the average of each measurement variable (mean and std) for each activity and subject. The primary key it’s represented by the concatenation of subject and activity (#subject_ACTIVITY). In the columns they are the features labels taken from the input file "features.txt" removing parenthesis to the characters containing the substrings “mean” and “std”.
