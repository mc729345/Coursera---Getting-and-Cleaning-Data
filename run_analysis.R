# set working directory
setwd("~/Dropbox/coursera/data science/getting and cleaning data - 4/UCI HAR Dataset")
library(tidyverse)

# read in training dataset
activities <- read.table(file = "activity_labels.txt", col.names = c("code", "Activity"))
features <- read.table(file = "features.txt", col.names = c("n", "functions"))
subject_train <- read.table(file = "./train/subject_train.txt", col.names = "Subject")
y_train <- read.table(file = "./train/Y_train.txt", col.names ="code")
x_train <- read.table(file = "./train/X_train.txt", col.names = features$functions)
subject_test <- read.table(file = "./test/subject_test.txt", col.names = "Subject")
y_test <- read.table(file = "./test/Y_test.txt", col.names = "code")
x_test <- read.table(file = "./test/X_test.txt", col.names = features$functions)

# combine and tidy
subject_all <- rbind(subject_train, subject_test)
y_all <- rbind(y_train, y_test)
x_all <- rbind(x_train, x_test)
data_all <- cbind(subject_all, y_all, x_all)

tidy_up <- data_all %>% 
                select(Subject, code, contains("mean"), contains("std"))

# recode activities into tidy_up 
tidy_up$code <- activities[tidy_up$code, 2]

# applying descriptive labels
# names(tidy_up)
names(tidy_up)[2] = "Activity"
names(tidy_up) <- gsub("Acc", "Accelerometer", names(tidy_up))
names(tidy_up) <- gsub("Gyro", "Gyroscope", names(tidy_up))
names(tidy_up) <- gsub("BodyBody", "Body", names(tidy_up))
names(tidy_up) <- gsub("Mag", "Magnitude", names(tidy_up))
names(tidy_up) <- gsub("^t", "Time", names(tidy_up))
names(tidy_up) <- gsub("^f", "Frequency", names(tidy_up))
names(tidy_up) <- gsub("tBody", "Body_time", names(tidy_up))
names(tidy_up) <- gsub("-mean()", "Mean", names(tidy_up), ignore.case = TRUE)
names(tidy_up) <- gsub("-std()", "Std_deviation", names(tidy_up), ignore.case = TRUE)
names(tidy_up) <- gsub("-freq()", "Frequency", names(tidy_up), ignore.case = TRUE)
names(tidy_up) <- gsub("angle", "Angle", names(tidy_up))
names(tidy_up) <- gsub("gravity", "Gravity", names(tidy_up))

# create new dataset, with average for each activity and each subject
        
tidy_summary <- tidy_up %>%
        group_by(Subject, Activity) %>%
        summarise_all(list(mean = mean))
write.table(tidy_summary, "SummaryData.txt", row.name=FALSE)

