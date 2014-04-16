setwd("~/")
setwd("Working Directory/UCI HAR Dataset")  # access folder containing data
feature <- read.table("features.txt")  # read-in names of variables
colneeded <-  sort(
                        c(grep("mean()",feature[,2]),
                          grep("std()",feature[,2])
                          )) # select columns that reference mean or st. dev and re-sort them
colret <- rep("NULL",561) 
# fill a vector with NULLs, which will be used when selecting which columns of data to ignore
colret[colneeded] <- "numeric"  # replace NULLs with numeric, for the columns we do want to read
setwd("test")
testdf <- read.table("X_test.txt",colClasses=colret)  # store the selected columns in testdf dataframe
testdf <- cbind(read.table("y_test.txt"),testdf)  # add a column for each row's activity
testdf <- cbind(read.table("subject_test.txt"),testdf)  # add a column for each row's subject
setwd("..//")
setwd("train")  # repeat process done for test cases, now with training cases
traindf <- read.table("X_train.txt",colClasses=colret) 
traindf <- cbind(read.table("y_train.txt"),traindf)
traindf <- cbind(read.table("subject_train.txt"),traindf)
comdf <- rbind(testdf,traindf)  # bind the test and training dataframes
colnames(comdf) <- c("subj","activity",paste(feature[colneeded,2]))  # name the columns
comdf <- comdf[order(comdf$subj,comdf$activity),]  # order the columns first by subj, then by activity
comdf[,2] <- sub(1,"walking",comdf[,2])  # rename activities from num to activity name, for clarity
comdf[,2] <- sub(2,"walking upstairs",comdf[,2])
comdf[,2] <- sub(3,"Walking downstairs",comdf[,2])
comdf[,2] <- sub(4,"sitting",comdf[,2])
comdf[,2] <- sub(5,"standing",comdf[,2])
comdf[,2] <- sub(6,"laying",comdf[,2])
library(reshape2)  # load reshape2 package in order to use melt and dcast functions
cheesemelt <- melt(
                comdf,id=c("activity","subj"),
                measure.vars=paste(feature[colneeded,2])
                )  # melt dataframe so that 79 mean & st dev variables condensed into 1 column
tidydata <- dcast(cheesemelt, activity+subj ~ variable,mean
                )  # condense data by averaging observations which share subj & activty 
write.csv(tidydata,file="tidydata_Jamie.csv")  # output the tidy data to a csv
