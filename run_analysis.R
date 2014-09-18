# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
# load data
featuresList <- read.table("./UCI HAR Dataset/features.txt",header=FALSE,colClasses="character")
#
# find out the column indices we are interested in
featuresOfInterest  <- grep(".*mean\\(\\)|.*std\\(\\)", featuresList[,2])
# ... and subset to only those columns
featuresList <- featuresList[featuresOfInterest,]
#
# read the activityLabels
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
#
# read test set
testSet <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
#
# filter to features of interest
testSet <- testSet[, featuresOfInterest]
# 
# append labels
testSet[, ncol(testSet) + 1] <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
#
# append subject
testSet[, ncol(testSet) + 1] <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
#
# read test set
trainSet <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
#
# filter to features of interest
trainSet <- trainSet[, featuresOfInterest]
# 
# append labels
trainSet[, ncol(trainSet) + 1] <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
#
# append subject
trainSet[, ncol(trainSet) + 1] <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)
#
# merge the data
allData <- rbind(trainSet, testSet)
#
# add column names to the data 
colnames(allData) <- c(featuresList$V2, "activity", "subject")
#
# ... and make them factors
allData$activity <- as.factor(allData$activity)
allData$subject <- as.factor(allData$subject)
#
# calculate mean for each variable by the factors (activity and subject)
# ignore the last two columns - our factors
summaryData <- aggregate(allData[, c(1:(ncol(allData) - 2))], by = list(activity = allData$activity, subject = allData$subject), mean)
#
# write summary data to table
write.table(summaryData, "tidy.txt", row.name=FALSE)
