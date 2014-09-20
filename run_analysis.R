##1.Merges the training and the test sets to create one data set

train3 = read.table("UCI HAR Dataset\\train\\X_train.txt")
train2 = read.table("UCI HAR Dataset\\train\\y_train.txt")
train1 = read.table("UCI HAR Dataset\\train\\subject_train.txt")

train <- cbind(train1,train2,train3)

test3 = read.table("UCI HAR Dataset\\test\\X_test.txt")
test2 = read.table("UCI HAR Dataset\\test\\y_test.txt")
test1 = read.table("UCI HAR Dataset\\test\\subject_test.txt")

test <- cbind(test1,test2,test3)

mergeddata <- rbind(train,test)


##2.Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("UCI HAR Dataset\\features.txt")
names(mergeddata) <- c("subject", "activity_id", as.character(features$V2))
extract <- mergeddata[,grep("mean|std|activity_id|subject", names(mergeddata))]

##3.Uses descriptive activity names to name the activities in the data set.

activity_names <-read.table("UCI HAR Dataset\\activity_labels.txt")
names(activity_names) <- c("activity_id", "activity")

activity_data <- merge(extract, activity_names, by.x="activity_id", by.y="activity_id")


##4.Appropriately labels the data set with descriptive variable names. 

final_data <- activity_data[,c(1,82,2:81)]


##5.From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

final_data <- final_data[order(final_data$activity_id, final_data$subject),]


tidy_data <-aggregate(final_data, by=list(final_data[,2], final_data[,3]), FUN="mean")
tidy_data <- tidy_data[ ,c(1,2,6:84)]
names(tidy_data)[1]<-"activity"
names(tidy_data)[2]<-"subject"

write.table(tidy_data, "tidy_data.txt", row.names=FALSE)


