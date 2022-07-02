## step 1 downloading and unzipping.

url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,"C:/Users/wrack/Documents/project.zip")
unzip("C:/Users/wrack/Documents/project.zip",exdir = "./data")

##merging the trainig and test data sets to create one data set

#reading data sets

x_train<-read.table("C:/Users/wrack/Documents/data/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("C:/Users/wrack/Documents/data/UCI HAR Dataset/train/Y_train.txt")
y_test<-read.table("C:/Users/wrack/Documents/data/UCI HAR Dataset/test/Y_test.txt")
x_test<-read.table("C:/Users/wrack/Documents/data/UCI HAR Dataset/test/X_test.txt")
subject_test<-read.table("C:/Users/wrack/Documents/data/UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("C:/Users/wrack/Documents/data/UCI HAR Dataset/train/subject_train.txt")
features<-read.table("C:/Users/wrack/Documents/data/UCI HAR Dataset/features.txt")
activitylabels<-read.table("C:/Users/wrack/Documents/data/UCI HAR Dataset/activity_labels.txt")

#assigning names

colnames(x_train)<-features[,2]
colnames(y_train)<-"activityId"
colnames(subject_train)<-"subjectId"
colnames(x_test)<-features[,2]
colnames(y_test)<-"activityId"
colnames(subject_test)<-"subjectId"
colnames(activitylabels)<-c('activityId','activitytype')

#merging data 

mrg_train<-cbind(x_train,y_train,subject_train)
mrg_test<-cbind(x_test,y_test,subject_test)
setallinone<-rbind(mrg_train,mrg_test)
colNames<-colnames(setallinone)
colNames <- colnames(setAllInOne)
mean_and_std <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
)
setForMeanAndStd <- setallinone[ , mean_and_std == TRUE]

##discriptive names

setWithActivityNames <- merge(setForMeanAndStd, activitylabels,
                              by='activityId',
                              all.x=TRUE)
##making second tidy data set

secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)