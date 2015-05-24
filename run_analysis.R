# Load libraries required
library(dplyr)

## Set up some global variables and functions
subDir <- "data"
mainDir <- getwd()
fileName <- "Data.zip"
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Activity function that will be used to map activity codes to activity
# labels
activity <- (function(x) {
						if (x == 1) return ('WALKING')
						if (x == 2) return ('WALKING_UPSTAIRS')
						if (x == 3) return ('WALKING_DOWNSTAIRS')
						if (x == 4) return ('SITTING')
						if (x == 5) return ('STANDING')
						if (x == 6) return ('LAYING')
}    ) 

## Will write to a "data" directory under the active working directory
## Check if directory exists, if not create it
if (file.exists(subDir)){
    setwd(file.path(mainDir, subDir))
} else {
    dir.create(file.path(mainDir, subDir))
    setwd(file.path(mainDir, subDir))
    mainDir <- getwd()
}

## Full path to zip file to be downloaded
fullPath <- file.path(mainDir, fileName)

## Download file 
download.file(fileUrl, fullPath, method = "curl")

## Unzip file
unzip(fullPath, overwrite = TRUE)

## Read X_*, y_* and subject_* files into variables
TestDir <- file.path(mainDir, "UCI HAR Dataset/test")
TrainDir <- file.path(mainDir, "UCI HAR Dataset/train")

X_test <- read.table(file = file.path(TestDir, "X_test.txt"))
X_train <- read.table(file=file.path(TrainDir, "X_train.txt"))

y_test <- read.table(file=file.path(TestDir, "y_test.txt"))
y_train <- read.table(file=file.path(TrainDir, "y_train.txt"))

subject_test <- read.table(file=file.path(TestDir, "subject_test.txt"))
subject_train <- read.table(file=file.path(TrainDir, "subject_train.txt"))

## Merge training and test sets for X_*, y_* and subject_* data
## and then add activity labels and subject data
X_all <- rbind(X_test, X_train)
y_all <- rbind(y_test, y_train)
subject_all <- rbind(subject_test, subject_train)

## Add activity label to data set
y_all <- rename(y_all, activity_code=V1)
y_all$activity_label <- sapply(y_all$activity_code, activity)

## Rename V1 column name in subject data to prevent confusion
subject_all <- rename(subject_all, subject_id=V1)

## Create master data set of everything
Data <- cbind(X_all, y_all, subject_all)

## Remove variables no longer needed
rm(X_all, y_all, subject_all, X_test, y_test, X_train, y_train, subject_test, subject_train)

#Extracts only the measurements on the mean and standard deviation for each measurement. 
Data_set <- select(Data, subject_id, activity_code, activity_label, V1:V6, V41:V46, V81:V86, V121:V126, V161:V166, V201:V202, 
	V214:V215, V227:V228, V240:V241, V253:V254, V266:V271, V345:V350, V424:V429,V503:V504, V516:V517, V529:V530, V542:V543)

# Change all column names to be descriptive

Data_set <- rename(Data_set, tbodyAccMeanX = V1,
							 tbodyAccMeanY = V2,
							 tbodyAccMeanZ = V3,
							 tbodyAccStdX = V4,
							 tbodyAccStdY = V5,
							 tbodyAccStdZ = V6,
							 tgravityAccMeanX = V41,
							 tgravityAccMeanY = V42,
							 tgravityAccMeanZ = V43,
							 tgravityAccStdX = V44,
							 tgravityAccStdY = V45,
							 tgravityAccStdZ = V46,
							 tbodyAccJerkMeanX = V81,
							 tbodyAccJerkMeanY = V82,
							 tbodyAccJerkMeanZ = V83,
							 tbodyAccJerkStdX = V84,
							 tbodyAccJerkStdY = V85,
							 tbodyAccJerkStdZ = V86,
							 tbodyGyroMeanX = V121,
							 tbodyGyroMeanY = V122,
							 tbodyGyroMeanZ = V123,
							 tbodyGyroStdX = V124,
							 tbodyGyroStdY = V125,
							 tbodyGyroStdZ = V126,
							 tbodyGyroJerkMeanX = V161,
							 tbodyGyroJerkMeanY = V162,
							 tbodyGyroJerkMeanZ = V163,
							 tbodyGyroJerkStdX = V164,
							 tbodyGyroJerkStdY = V165,
							 tbodyGyroJerkStdZ = V166,
							 tbodyAccMagMean = V201,
							 tbodyAccMagStd = V202,
							 tgravityAccMagMean = V214,
							 tgravityAccMagStd = V215,
							 tbodyAccJerkMagMean = V227,
							 tbodyAccJerkMagStd = V228,
							 tbodyGyroMagMean = V240,
							 tbodyGyroMagStd = V241,
							 tbodyGyroJerkMagMean = V253,
							 tbodyGyroJerkMagStd = V254,
							 fbodyAccMeanX = V266,
							 fbodyAccMeanY = V267,
							 fbodyAccMeanZ = V268,
							 fbodyAccStdX = V269,
							 fbodyAccStdY = V270,
							 fbodyAccStdZ = V271,
							 fbodyAccJerkMeanX = V345,
							 fbodyAccJerkMeanY = V346,
							 fbodyAccJerkMeanZ = V347,
							 fbodyAccJerkStdX = V348,
							 fbodyAccJerkStdY = V349,
							 fbodyAccJerkStdZ = V350,
							 fbodyGyroMeanX = V424,
							 fbodyGyroMeanY = V425,
							 fbodyGyroMeanZ = V426,
							 fbodyGyroStdX = V427,
							 fbodyGyroStdY = V428,
							 fbodyGyroStdZ = V429,
							 fbodyAccMagMean = V503,
							 fbodyAccMagStd = V504,
							 fbodyBodyAccJerkMagMean = V516,
							 fbodyBodyAccJerkMagStd = V517,
							 fbodyBodyGyroMagMean = V529,
							 fbodyBodyGyroMagStd = V530,
							 fbodyBodyGyroJerkMagMean = V542,
							 fbodyBodyGyroJerkMagStd = V543)

#From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

DataGroup <- group_by(Data_set, subject_id, activity_label)

DataSet2 <- summarize(DataGroup,tbodyAccMeanX = mean(tbodyAccMeanX, na.rm = TRUE),
					tbodyAccMeanY = mean(tbodyAccMeanY, na.rm = TRUE),
					tbodyAccMeanZ = mean(tbodyAccMeanZ, na.rm = TRUE),
					tbodyAccStdX = mean(tbodyAccStdX, na.rm = TRUE),
					tbodyAccStdY = mean(tbodyAccStdY, na.rm = TRUE),
					tbodyAccStdZ = mean(tbodyAccStdZ, na.rm = TRUE),
					tgravityAccMeanX = mean(tgravityAccMeanX, na.rm = TRUE),
					tgravityAccMeanY = mean(tgravityAccMeanY, na.rm = TRUE),
					tgravityAccMeanZ = mean(tgravityAccMeanZ, na.rm = TRUE),
					tgravityAccStdX = mean(tgravityAccStdX, na.rm = TRUE),
					tgravityAccStdY = mean(tgravityAccStdY, na.rm = TRUE),
					tgravityAccStdZ = mean(tgravityAccStdZ, na.rm = TRUE),
					tbodyAccJerkMeanX = mean(tbodyAccJerkMeanX, na.rm = TRUE),
					tbodyAccJerkMeanY = mean(tbodyAccJerkMeanY, na.rm = TRUE),
					tbodyAccJerkMeanZ = mean(tbodyAccJerkMeanZ, na.rm = TRUE),
					tbodyAccJerkStdX = mean(tbodyAccJerkStdX, na.rm = TRUE),
					tbodyAccJerkStdY = mean(tbodyAccJerkStdY, na.rm = TRUE),
					tbodyAccJerkStdZ = mean(tbodyAccJerkStdZ, na.rm = TRUE),
					tbodyGyroMeanX = mean(tbodyGyroMeanX, na.rm = TRUE),
					tbodyGyroMeanY = mean(tbodyGyroMeanY, na.rm = TRUE),
					tbodyGyroMeanZ = mean(tbodyGyroMeanZ, na.rm = TRUE),
					tbodyGyroStdX = mean(tbodyGyroStdX, na.rm = TRUE),
					tbodyGyroStdY = mean(tbodyGyroStdY, na.rm = TRUE),
					tbodyGyroStdZ = mean(tbodyGyroStdZ, na.rm = TRUE),
					tbodyGyroJerkMeanX = mean(tbodyGyroJerkMeanX, na.rm = TRUE),
					tbodyGyroJerkMeanY = mean(tbodyGyroJerkMeanY, na.rm = TRUE),
					tbodyGyroJerkMeanZ = mean(tbodyGyroJerkMeanZ, na.rm = TRUE),
					tbodyGyroJerkStdX = mean(tbodyGyroJerkStdX, na.rm = TRUE),
					tbodyGyroJerkStdY = mean(tbodyGyroJerkStdY, na.rm = TRUE),
					tbodyGyroJerkStdZ = mean(tbodyGyroJerkStdZ, na.rm = TRUE),
					tbodyAccMagMean = mean(tbodyAccMagMean, na.rm = TRUE),
					tbodyAccMagStd = mean(tbodyAccMagStd, na.rm = TRUE),
					tgravityAccMagMean = mean(tgravityAccMagMean, na.rm = TRUE),
					tgravityAccMagStd = mean(tgravityAccMagStd, na.rm = TRUE),
					tbodyAccJerkMagMean = mean(tbodyAccJerkMagMean, na.rm = TRUE),
					tbodyAccJerkMagStd = mean(tbodyAccJerkMagStd, na.rm = TRUE),
					tbodyGyroMagMean = mean(tbodyGyroMagMean, na.rm = TRUE),
					tbodyGyroMagStd = mean(tbodyGyroMagStd, na.rm = TRUE),
					tbodyGyroJerkMagMean = mean(tbodyGyroJerkMagMean, na.rm = TRUE),
					tbodyGyroJerkMagStd = mean(tbodyGyroJerkMagStd, na.rm = TRUE),
					fbodyAccMeanX = mean(fbodyAccMeanX, na.rm = TRUE),
					fbodyAccMeanY = mean(fbodyAccMeanY, na.rm = TRUE),
					fbodyAccMeanZ = mean(fbodyAccMeanZ, na.rm = TRUE),
					fbodyAccStdX = mean(fbodyAccStdX, na.rm = TRUE),
					fbodyAccStdY = mean(fbodyAccStdY, na.rm = TRUE),
					fbodyAccStdZ = mean(fbodyAccStdZ, na.rm = TRUE),
					fbodyAccJerkMeanX = mean(fbodyAccJerkMeanX, na.rm = TRUE),
					fbodyAccJerkMeanY = mean(fbodyAccJerkMeanY, na.rm = TRUE),
					fbodyAccJerkMeanZ = mean(fbodyAccJerkMeanZ, na.rm = TRUE),
					fbodyAccJerkStdX = mean(fbodyAccJerkStdX, na.rm = TRUE),
					fbodyAccJerkStdY = mean(fbodyAccJerkStdY, na.rm = TRUE),
					fbodyAccJerkStdZ = mean(fbodyAccJerkStdZ, na.rm = TRUE),
					fbodyGyroMeanX = mean(fbodyGyroMeanX, na.rm = TRUE),
					fbodyGyroMeanY = mean(fbodyGyroMeanY, na.rm = TRUE),
					fbodyGyroMeanZ = mean(fbodyGyroMeanZ, na.rm = TRUE),
					fbodyGyroStdX = mean(fbodyGyroStdX, na.rm = TRUE),
					fbodyGyroStdY = mean(fbodyGyroStdY, na.rm = TRUE),
					fbodyGyroStdZ = mean(fbodyGyroStdZ, na.rm = TRUE),
					fbodyAccMagMean = mean(fbodyAccMagMean, na.rm = TRUE),
					fbodyAccMagStd = mean(fbodyAccMagStd, na.rm = TRUE),
					fbodyBodyAccJerkMagMean = mean(fbodyBodyAccJerkMagMean, na.rm = TRUE),
					fbodyBodyAccJerkMagStd = mean(fbodyBodyAccJerkMagStd, na.rm = TRUE),
					fbodyBodyGyroMagMean = mean(fbodyBodyGyroMagMean, na.rm = TRUE),
					fbodyBodyGyroMagStd = mean(fbodyBodyGyroMagStd, na.rm = TRUE),
					fbodyBodyGyroJerkMagMean = mean(fbodyBodyGyroJerkMagMean, na.rm = TRUE),
					fbodyBodyGyroJerkMagStd = mean(fbodyBodyGyroJerkMagStd, na.rm = TRUE))

## Write table out

write.table(DataSet2, file = file.path(mainDir, "TidyDataSet2.txt"), sep = ",", col.names = TRUE, row.name = FALSE)


