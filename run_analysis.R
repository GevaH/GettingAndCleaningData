library(dplyr)

# Preprocess part 1 - The script will check if there's a folder for the project's data. If not, it will create one.
# Then, it'll download the .zip file and extract it.

if(!file.exists("./finalProject")){dir.create("./finalProject")}
fileUrl  = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileDest = "./finalProject/courseProjectData.zip"
download.file(fileUrl, fileDest)
unzip(fileDest,exdir = "./finalProject")

# Preprocess part 2 - The script will import the necessary data into RStudio's workspace.
# That includes (in order): test data, train data, activity labels and features list.

xTest          <- read.table("./finalProject/UCI HAR Dataset/test/x_test.txt")
yTest          <- read.table("./finalProject/UCI HAR Dataset/test/y_test.txt")
subjectTest    <- read.table("./finalProject/UCI HAR Dataset/test/subject_test.txt")

xTrain         <- read.table("./finalProject/UCI HAR Dataset/train/x_train.txt")
yTrain         <- read.table("./finalProject/UCI HAR Dataset/train/y_train.txt")
subjectTrain   <- read.table("./finalProject/UCI HAR Dataset/train/subject_train.txt")

activityLabels <- read.table("./finalProject/UCI HAR Dataset/activity_labels.txt")
features       <- read.table("./finalProject/UCI HAR Dataset/features.txt")

# Requirement 1 - Joining frames.

test    <- cbind(subjectTest, yTest, xTest)
train   <- cbind(subjectTrain, yTrain, xTrain)
allData <- rbind(test, train)

# Requirement 2 - create a table with mean and std data only.
# Part 2a - find where msd and mean data are and flag them.

stdIndices    <- grep("std", features[,2])
meanIndices   <- grep("mean", features[,2])
takeStd       <- stdIndices + 2  # We tell the script which columns to take.
takeMean      <- meanIndices + 2 # We add 2 because the first two columns are the subject and activity number, respectively.

# Part 2b - saving all necessary indices including activity and subject numbers.

indiceswanted <- c(1:2, takeMean, takeStd)
dataWanted    <- allData[ , indiceswanted]

# Requests 4 - Assigning descriptive name to the activities.

colnames(dataWanted) <- c("subjectNumber","activityNumber", as.character(features[meanIndices, 2]), as.character(features[stdIndices, 2]))

# Request 5 - Calculating mean for each activity for each participant.

tidyFrame <- aggregate(. ~subjectNumber + activityNumber, dataWanted, mean)

# Request 3 - Using descriptive names for the features.

colnames(activityLabels) <- c("activityNumber", "activityName") # Preparing for merging.
dataWantedLitAct         <- merge(activityLabels, tidyFrame, by = "activityNumber") # Merging. LitAct stands for 'Literal Activity'.
finalTidyFrame           <- arrange(dataWantedLitAct, subjectNumber, activityNumber) # Sorting.

# Finally, getting rid of the meaningless column "activityNumber" since we're using descriptive names here.

finalTidyFrame$activityNumber <- NULL

# And reorginizing the first two column to make it more tidy.

finalFrameDim                 <- dim(finalTidyFrame)
finalTidyFrame                <- finalTidyFrame[,c(2,1,3:finalFrameDim[2])]

# Saving the tidy data into a file.

write.table(finalTidyFrame, "./dataFile.txt", row.names = FALSE ,sep = "\t")
