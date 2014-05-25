### HOW run_analysis.R works.

The scrite assume the following all files are in the same folder as run_analysis.R.

run_analysis.R does the following:

* Reads the data files
* Reads the features and activity file
* Renames columns
* Uses the feature data to rename the x columns
* Calculates which data is for mean and std readings by using the feature description
* Subsets the x test and training data for mean and std 
* Combines the test and training set
* Aggregates means by Subject and Activity
* Replaces the Activity number with the Activity string
* Tidys up the dataframe by removing columns created by the aggregate function
* Adds "mean." to the colunm names and tidys up the colunm names
* Writes the dataframe to the file tidy_data.txt


