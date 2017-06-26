# Getting and Cleaning Data - code book for the final project

## The data
The data to be analyzed in this excercise was taken as part of a Human activity Recognition (HAR) using smartphones research. A full description is available at[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) <br>
The data for this project can be downloaded from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) <br>

## Variables within the script
The script creates variables within R workspace. Those would be: <br>
`xTest`, `yTest`, `subjectTest` and `xTrain`, `yTrain`, `subjectTrain` for the features' data, feature ID and subject ID, respectively for the test and train data, respectively. <br>
`activityLabels` and `features` are used as descriptive names for the activities and features, respectively.

## The script
The script is composed of five main parts (corresponding to assignments' requirements) and a last part for representation purposes. <br>
Part 1 is joining the test and train datasets. <br>
Part 2 extracts only mean and standard deviation data. <br>
Part 3 fulfills the 4th requirement by adding descriptive activity names. <br>
Part 4 fulfills the 5th request by extracting the mean value for each variable for each activity and for each subject. <br>
Part 5 assigns descriptive names for the features. <br>

The last part keeps only descriptive names and reorganizes the table so it'll look pretty and readable. Afterwards the final tidy data set is save into a .txt file.
