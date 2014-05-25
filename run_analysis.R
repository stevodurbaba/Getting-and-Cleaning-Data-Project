## Assumes data file are in the same folder as this R script

## read the data files
subject_test <- read.table("subject_test.txt")
x_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_train <- read.table("subject_train.txt")
x_train <- read.table("x_train.txt")
y_train <- read.table("y_train.txt")

# read the features and activity file

features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")



## renames columns
colnames(subject_test) <- "Subject"
colnames(subject_train) <- "Subject"
colnames(y_test) <- "Activity"
colnames(y_train) <- "Activity"
colnames(features) <- c("Num","Description")
colnames(activity_labels) <- c("Activity","Lables")


# use the feature data to rename columns
colnames(x_test) <- features$Description
colnames(x_train) <- features$Description



# calculate which data is for mean and std readings by using the Description
features$Required <- grepl("mean",features$Description) | grepl("std",features$Description)
Required <- which(features$Required == TRUE)

# subset the x test and training data for mean and std 
x_test_sub <-data.frame(x_test[,Required])
x_train_sub <-data.frame(x_train[,Required])

# combine test data
test_set <-cbind(subject_test,y_test)
test_set <-cbind(test_set,x_test_sub)

# combine training data
train_set <-cbind(subject_train,y_train)
train_set <-cbind(train_set,x_train_sub)


#combine test and training set
data_set <- rbind(test_set,train_set)


# aggregate means by Subject and Activity
agg_data <-aggregate(data_set, by=list(data_set$Subject,data_set$Activity),FUN=mean, na.rm=TRUE)

# replace the Activity number with the Activity stringr
agg_data$Activity <- activity_labels[agg_data$Activity,2]

#tidy up the dataframe by removing columns created by the aggregate function
agg_data$Group.1 <- NULL
agg_data$Group.2 <- NULL


# add "mean" to the colunm names
agg_colnames <-colnames(agg_data)
agg_colnames <- paste0("mean.",agg_colnames)
colnames(agg_data) <- agg_colnames

#tidy up the colunm names
colnames(agg_data)[1] <- "Subject"
colnames(agg_data)[2] <-  "Activity"


#write the dataframe to the file tidy_data.txt
write.table(agg_data,"tidy_data.txt", row.names = FALSE)


