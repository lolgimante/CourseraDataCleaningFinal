#      This program reads dataset splitted into two files, merges it,
#      writes it into file (if write_set = TRUE), extracts subset of #      containing only means and standard deviations of variables and
#      finally calculates means for the data in the subset.

#  Variables:
#     set : contains concatenated data (whole dataset)
#     subset_ : only the measurements on the mean and standard deviation for each measurement(unique by collection of [activity, subject, feature AND observation number])
#     subset_final : contains the average of each variable for each activity and each subject  

#SET VARIABLES:
write_set = TRUE
setwd("UCI HAR Dataset")
odir <- "all"

#--------------------------------------
#creates output directory for merged dataset:
if (!file.exists(odir)) {
  dir.create(odir)
}

#read features:
features <- read.csv("features.txt", header=FALSE, sep=" ")[,2]
activity_labels <- read.csv("activity_labels.txt", header=FALSE, sep=" ")
#--------
#read subject id's of train and test datasets and merge:
  subjects <- c(read.csv("./train/subject_train.txt", header=FALSE, sep="")[,1],
                   read.csv("./test/subject_test.txt", header=FALSE, sep="")[,1])
#--------
#read activity id's and then fill the array of activity labels according to the id's list:
  activity_no <- c(read.csv("./train/y_train.txt", header=FALSE, sep="")[,1],
                   read.csv("./test/y_test.txt", header=FALSE, sep="")[,1])
  activity_lbl <- activity_labels[match(activity_no, activity_labels[,1]),2]
#--------
#Merges the training and the test sets to create one data set.
  set <- rbind(read.csv("./train/x_train.txt", header=FALSE, sep="", dec=".",  colClasses="numeric"), 
        read.csv("./test/x_test.txt", header=FALSE, sep="", dec=".", colClasses="numeric"))
  #rename columns(features):
  colnames(set) <- features
  #create activity_P{subjectNumber} column:
  set <-cbind(paste(activity_lbl,subjects,sep="_P"), set)
  colnames(set)[1] <- "activity_subject"
  #rownames(set) <- make.names(paste(activity_lbl,subjects,sep="_P"),unique=TRUE)
  #make.names(paste("sub_",subjects,sep=""),unique=TRUE)
#--------
#write merged data set to file (if write_set = TRUE):
  if (write_set == TRUE) {
    write.table(set, file = paste("./",odir,"/x_all.txt",sep=""), append = FALSE, sep=" ",dec = ".",row.names=FALSE,col.names=FALSE)
  }
#--------
#Extracts only the measurements on the mean and standard deviation for each measurement.
  idx_mean <- grep("mean\\(\\)", features)
  idx_std <- grep("std\\(\\)", features)
  subset_ <- set[,c(idx_mean,idx_std)]
  
#From the subset_ creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  subset_final <- aggregate(x=subset_[,-1], by=list(activity_subject=subset_$activity_subject), FUN = mean)
  if (write_set == TRUE) {
    write.table(subset_final, file = paste("./",odir,"/x_subset.txt",sep=""), append = FALSE, sep=" ",dec = ".",row.names=FALSE,col.names=TRUE)
  }


