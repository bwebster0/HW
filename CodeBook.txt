CodeBook for 'run_analysis.R'


Raw Data from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

"features_info.txt" in the original data set defines the features of the data set, to which the "output.txt" tidy data
   has extracted only the *mean() and *std() sets.
The tidy data set 'output.txt' provides the mean for each of the chosen variables for each 'activity' and 'subject'.
   There are 30 subjects and 6 activities.
"http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones" contains the full description
   of the study that created the original data set.


Code Design
-----------
The approach was to take the creation of the tidy data in a step-by-step fashion:
- read
- label
- combine
- extract variables of interest, mean() and std()
- define activities by name
- combine to final data set, test and train
- create tidy data = means per activity per subject
- output to file


Variable List
-------------
data_* : raw data as read in from 'raw' files
train/test : combined form of the raw data into a single table for each set train and test
ltrain/ltest : a subset of train/test of just the columns of mean()/std() values
     k : index of columns containing mean()/std() values
ltrainl/ltestl : the limited data sets with the activity names provided, not just the number
     representation of the activity
finalData : a combined data set of the train and test data
m : melted data comparing "TrainingLabel" and "Subject" to the rest
mFinal : final tidy data set form the melted data
