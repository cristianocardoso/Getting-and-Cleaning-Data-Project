# # Getting and Cleaning Data Course Project
# 1 - Merges the training and the test sets to create one data set

x_train <- read.table("train/x_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

# files from "test" folder
# "test" variables

x_test <- read.table("test/x_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# "data" variables

x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

# 2 - Extracts only the measurements on the mean and standard deviation for each measurement

# See the file "features_info.txt"
# The complete list of variables of each feature vector is available in 'features.txt'

features <- read.table("features.txt")
features_mean_std <- grep("-(mean|std)\\(\\)", features[, 2])
x_data <- x_data[, features_mean_std]
names(x_data) <- features[features_mean_std, 2]

# 3 - Uses descriptive activity names to name the activities in the data set

# Take a look at "activity_labels.txt"

activities <- read.table("activity_labels.txt")
names(y_data) <- "activity"

# 4 - Appropriately labels the data set with descriptive variable names

names(subject_data) <- "subject"
complete_data <- cbind(x_data, y_data, subject_data)

# 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

averages <- ddply(complete_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averages, "averages.txt", row.name=FALSE)
# end!
