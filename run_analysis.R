#This script presumes that the UCI HAR Dataset has been downloaded
#and unzipped, and the directory "UCI HAR Dataset" is in the current
#working directory.

library(data.table)
library(dplyr)
library(dtplyr)

path <- "UCI HAR Dataset"

#Extract the observations of each experiment which are means or stdevs of some quantity:

features <- read.table(paste0(path, "/features.txt"))
features_dp <- tbl_df(features)
features_dp <- mutate(features_dp, V2 = as.character(V2))

is_mean <- grep("mean[^F]", features_dp$V2)
is_std <- grep("std", features_dp$V2)
means_and_stdevs <- features_dp[c(is_mean, is_std), ]

#Read in the training set, adding subject and activity data

train <- fread(paste0(path, "/train/X_train.txt"), select = means_and_stdevs$V1)
train_dp <- tbl_df(train)

train_sub <- read.table(paste0(path, "/train/subject_train.txt"))
train_sub_dp <- tbl_df(train_sub)
train_sub_dp <- rename(train_sub_dp, subject=V1) 

train_act <- read.table(paste0(path, "/train/y_train.txt"))
train_act_dp <- tbl_df(train_act)
train_act_dp <- rename(train_act_dp, action=V1)

train_total <- bind_cols(train_sub_dp, train_act_dp, train_dp)

#Give the measurements real names:
num_meas <- nrow(means_and_stdevs) 
names(train_total)[3:(num_meas+2)] = means_and_stdevs$V2

#Do the identical thing for the test data

test <- fread(paste0(path, "/test/X_test.txt"), select = means_and_stdevs$V1)
test_dp <- tbl_df(test)

test_sub <- read.table(paste0(path, "/test/subject_test.txt"))
test_sub_dp <- tbl_df(test_sub)
test_sub_dp <- rename(test_sub_dp, subject=V1) 

test_act <- read.table(paste0(path, "/test/y_test.txt"))
test_act_dp <- tbl_df(test_act)
test_act_dp <- rename(test_act_dp, action=V1)

test_total <- bind_cols(test_sub_dp, test_act_dp, test_dp)
names(test_total)[3:(num_meas+2)] = means_and_stdevs$V2

#Unify test and training data

all_data <- bind_rows(test_total,train_total)

#Give the activity names descriptive values instead of integers.

act_labels <- read.table(paste0(path, "/activity_labels.txt"))
describe <- function(x){
	act_labels$V2[x]
}

all_data <- mutate(all_data, action = describe(action))

#Produce a tidy data set taking the means of each variable for each
#activity/subject pair. 

tidy <- all_data %>% group_by(action, subject) %>% summarize_all(mean) %>% ungroup()

tidy


