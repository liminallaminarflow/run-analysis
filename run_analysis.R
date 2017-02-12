#set up environment with appopriate packages
library(reshape2)
library(plyr)


#download data, set working directory
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile = "week4.zip")
unzip("week4.zip")
setwd("UCI HAR Dataset")

#prepare names for imported files
files <- list.files(recursive = TRUE)

datanames <- gsub("[.]txt", "", files)
datanames <- gsub("/", "_", datanames)
datanames <- gsub(" ", "_", datanames)

#import  files into R and name them
activity_labels <- read.table("activity_labels.txt", stringsAsFactors = FALSE)[, 2]
features <- read.table("features.txt", stringsAsFactors = FALSE)[, 2]

i = 5
for(i in 5:length(files)) {
      assign(datanames[i], 
             read.table(files[i]))
}

#merge datasets & name columns (this addresses both steps 1 and 4) 
testset <- cbind(test_subject_test, test_y_test, test_X_test)
trainset <- cbind(train_subject_train, train_y_train, train_X_train)
alldata <- rbind(trainset, testset)
names <- c("Subject", "Activity", features)
colnames(alldata) <- names

#subset merged data to include only measurements pertaining to mean or standard deviation (step 2)
subdata <- alldata[, c(1:2, grep("*[Mm]ean*|*std*", colnames(alldata)))]

#replace activity label integer values with activity label names in subsetted data (step 3)
i = 1
for(i in 1:length(activity_labels)) {
      subdata$Activity[subdata$Activity == i] <- activity_labels[i]
}

#melt data to create tall data set with a row for each subject/activity/variable/value
meltdata <- melt(subdata, 1:2)

#create second, independent tidy data set with the average 
#of each variable for each activity and each subject (step 5)
tidydata <- ddply(meltdata, c("Subject", "Activity", "variable"), summarise, mean_observation = mean(value))

#export .txt file
write.table(tidydata, file = "tidy_sensor_data.txt", row.names = FALSE)
