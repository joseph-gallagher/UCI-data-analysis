# UCI-data-analysis

The UCI HAR Dataset (henceforth: dataset), available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
contains data obtained by analyzing 10,000 experiments recording the motion of some 30 subjects performing one of 6 common tasks. These observations have been split randomly into a "test" and a "train" data set. 
In each experiment, approximately 750 features of the motion are measured. These quantities are given in the "features.txt" file inside the dataset. 

The file "run_analysis.R" is meant to be sourced while it is in the same directory as the dataset. It accomplishes the following:

- It unifies the test and train data.
- It extracts only the features which themselves are means or standard deviations of some quantity
- For each of the 180 (subject, action) pairs, it calculates the mean of each of the above features (over all experiments)
- It returns said data in a data frame (really, a dplyr 'tibble')

NOTE: The file "run_analysis.R" has the following package requirements:

- data.table
- dplyr
- dtplyr


