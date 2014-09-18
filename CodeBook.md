## Description
this file describes the R script run_analysis.R. The purpose of this file is to read in activity data from accelerometers from a Samsung Galaxy S smartphone. The data is cleaned and summarised to provide the average of the mean and sd variables in this data set. this script was written to fulfil the requirements of the coursera course [getting and cleaning data](https://class.coursera.org/getdata-007/)

##Variables

###featuresList
read from file; the list of features contained in the dataset

###featuresOfInterest
derived by extracting the columns from featuresOfInterest that represent standard deviation (std) and mean (mean) measurements.

###activityLabels
read from file; the list of activities that the subject was doing when reading were taken i.e. WALKING, WALKING_UPSTAIRS, ...

###testSet
read from file; the test set portion of the dataset

###trainSet
read from file; the training set portion of the dataset

###allData
This data has had the following done to it
* training and test sets merged together
* features that are not sd or mean measurements have been removed
* activities have been labeled with their textual description
* the subject identifier has been added to each row

###summaryData
allData set summarised by taking the mean of each feature in allData grouped by subject and activity

the summaryData data set is written to a file tidy.txt
