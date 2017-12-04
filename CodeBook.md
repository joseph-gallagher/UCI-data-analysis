# Code Book for "run_analysis.R"

The features of motion analyzed in each experiment in the original UCI HAR Dataset (henceforth: dataset) are

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

where the suffix -XYZ denotes three separate features, split along X, Y and Z-axes. For more detailed
information about what each of these mean and how they were originally recorded, see the file "features_info.txt"
in the dataset. Over a single experiment, the mean and standard deviation of each of these quantities was recorded.

## Relation to tidy data produced by "run_analysis.R"

In the tidy data set produced by "run_analysis.R", we have a mean() and std() measurement for each quantity above.
As each row is labeled by a unique (subject, action) pair, these are to be understood as averages over all experiments
where both the subject and action are constant.

An example: 'tBodyAcc-mean()-X' would represent the average of the bodily acceleration (in the time domain) in the
X-direction over the course of all experiments for the (subject, action) pair determined by the row.



