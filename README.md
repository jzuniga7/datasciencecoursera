File: run_analysis.R

What it does:
run_analysis.R will produce a TidyDataSet2.txt file in the "data" directory of the current working directory. 

When run, the script will:
- Check if the "data" directory exists in the current directory, if not it will create it
- Download the source data from the internet
- Unzip the files
- Load the contents of the files X_test, y_test, X_train, y_train, subject_test, subject_train into data frames
- Merge all the data frames into one data frame
- Create a new column for 'activity label' based on the activity codes
- Rename the columns to have more descriptive names
- Get only the columns that are concerned with Mean and Std Dev
- Create a new tidy data set data frame and write it to a file "TidyDataSet2.txt"

TidyDataSet2 will have the following columns


VARIABLE NAME				POSITION	EXPLANATION

subject_id             		1 			Volunteer id of subject (1-30)
activity_label           	2     		Type of activity performed by subject
										one of WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,
										STANDING, SITTING, LAYING
tbodyAccMeanX            	3   		Average of tBodyAccMean in X-axis
tbodyAccMeanY            	4  			Average of tBodyAccMean in Y-axix
tbodyAccMeanZ            	5   		Average of tBodyAccMean in Z-axis
tbodyAccStdX             	6  			Average of Stdev of tBodyAcc in X-axis
tbodyAccStdY             	7   		Average of Stdev of tBodyAcc in Y-axis
tbodyAccStdZ             	8  			Average of Stdev of tBodyAcc in Z-axis
tgravityAccMeanX         	9  			Average of Mean of tGravityAcc in X-axis
tgravityAccMeanY         	10   		Average of Mean of tGravityAcc in Y-axis
tgravityAccMeanZ         	11   		Average of Mean of tGravityAcc in Z-axis
tgravityAccStdX          	12  		Average of Stdev of tGravityAcc in X-axis
tgravityAccStdY          	13   		Average of Stdev of tGravityAcc in Y-axis
tgravityAccStdZ          	14  		Average of Stdev of tGravityAcc in Z-axis
tbodyAccJerkMeanX        	15  		Average of Mean of tBodyAccJerk in X-axis
tbodyAccJerkMeanY        	16  		Average of Mean of tBodyAccJerk in Y-axis
tbodyAccJerkMeanZ        	17  		Average of Mean of tBodyAccJerk in Z-axis
tbodyAccJerkStdX        	18   		Average of Stdev of tBodyAccJerk in X-axis
tbodyAccJerkStdY        	19   		Average of Stdev of tBodyAccJerk in Y-axis
tbodyAccJerkStdZ        	20  		Average of Stdev of tBodyAccJerk in Z-axis
tbodyGyroMeanX           	21  		Average of Mean of tBodyGyro in X-axis
tbodyGyroMeanY   			22        	Average of Mean of tBodyGyro in Y-axis
tbodyGyroMeanZ           	23  		Average of Mean of tBodyGyro in Z-axis
tbodyGyroStdX            	24  		Average of Stdev of tBodyGyro in X-axis
tbodyGyroStdY            	25  		Average of Stdev of tBodyGyro in Y-axis
tbodyGyroStdZ            	26  		Average of Stdev of tBodyGyro in Z-axis
tbodyGyroJerkMeanX       	27  		Average of Mean of tBodyGyroJerk in X-axis
tbodyGyroJerkMeanY       	28  		Average of Mean of tBodyGyroJerk in Y-axis
tbodyGyroJerkMeanZ       	29  		Average of Mean of tBodyGyroJerk in Z-axis
tbodyGyroJerkStdX        	30  		Average of Stdev of tBodyGyroJerk in X-axis
tbodyGyroJerkStdY        	31  		Average of Stdev of tBodyGyroJerk in Y-axis
tbodyGyroJerkStdZ        	32  		Average of Stdev of tBodyGyroJerk in Z-axis
tbodyAccMagMean          	33  		Average of Mean of tBodyAccMag
tbodyAccMagStd           	34  		Average of Stdev of tBodyAccMag
tgravityAccMagMean       	35  		Average of Mean of tGravityAccMag
tgravityAccMagStd        	36  		Average of Stdev of tGravityAccMag
tbodyAccJerkMagMean      	37  		Average of Mean of tBodyAccJerkMag
tbodyAccJerkMagStd       	38  		Average of Stdev of tBodyAccJerkMag
tbodyGyroMagMean         	39  		Average of 	Mean of tBodyGyroMag
tbodyGyroMagStd          	40  		Average of Stdev of tBodyGyroMag
tbodyGyroJerkMagMean     	41  		Average of Mean of tBodyGyroJerkMag
tbodyGyroJerkMagStd      	42  		Average of Stdev of tBodyGyroJerkMag
fbodyAccMeanX            	43  		Average of Mean of fbodyAcc in X-axis
fbodyAccMeanY            	44   		Average of Mean of fbodyAcc in Y-axis
fbodyAccMeanZ            	45  		Average of Mean of fbodyAcc in Z-axis
fbodyAccStdX             	46  		Average of Stdev of fbodyAcc in X-axis
fbodyAccStdY             	47  		Average of Stdev of fbodyAcc in Y-axis
fbodyAccStdZ             	48  		Average of Stdev of fbodyAcc in Z-axis
fbodyAccJerkMeanX        	49   		Average of Mean of fBodyAccJerk in X-axis
fbodyAccJerkMeanY        	50			Average of Mean of fBodyAccJerk in Y-axis
fbodyAccJerkMeanZ        	51  		Average of Mean of fBodyAccJerk in Z-axis
fbodyAccJerkStdX         	52  		Average of Stdev of fBodyAccJerk in X-axis
fbodyAccJerkStdY         	53			Average of Stdev of fBodyAccJerk in Y-axis
fbodyAccJerkStdZ         	54   		Average of Stdev of fBodyAccJerk in Z-axis
fbodyGyroMeanX           	55  		Average of Mean of fbodyGyro in X-axis
fbodyGyroMeanY           	56  		Average of Mean of fbodyGyro in Y-axis
fbodyGyroMeanZ           	57  		Average of Mean of fbodyGyro in Z-axis
fbodyGyroStdX            	58  		Average of Stdev of fbodyGyro in X-axis
fbodyGyroStdY            	59  		Average of Stdev of fbodyGyro in Y-axis
fbodyGyroStdZ        		60      	Average of Stdev of fbodyGyro in Z-axis
fbodyAccMagMean          	61  		Average of Mean of fbodyAccMag
fbodyAccMagStd           	62  		Average of Stdev of fbodyAccMag
fbodyBodyAccJerkMagMean  	63  		Average of Mean of fBodyBodyAccJerkMag
fbodyBodyAccJerkMagStd   	64  		Average of Stdev of fBodyBodyAccJerkMag
fbodyBodyGyroMagMean     	65  		Average of Mean of fBodyBodyGyroMag
fbodyBodyGyroMagStd      	66   		Average of Stdev of fBodyBodyGyroMag
fbodyBodyGyroJerkMagMean 	67   		Average of Mean of fBodyBodyGyroJerkMag
fbodyBodyGyroJerkMagStd  	68 			Average of Stdev of fBodyBodyGyroJerkMag
