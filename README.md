How run_analysis.R works
run_analysis.R fulfills the five requirements laid out in the Week 4 assignment for the Getting and Cleaning Data Coursera course. It does so in the following fashion:
•	Sets up R environment with packages (reshape2, plyr) containing functions needed to conduct the analysis
•	Downloads the zipped data files, unzips them, and then sets the unzipped folder as R’s working directory
•	Prepares names for the to-be-imported files by extracting file names and paths recursively, then cleaning them so that the file names do not contain special characters
•	Imports activity labels and variable names
•	Imports files into R and assigns cleaned names to each
•	Merges training and testing datasets by first binding all training data and testing data respectively, then binding the resulting datasets to create a single dataset (Step 1)
•	Applies variable names to merged data frame (Step 4)
•	Replaces integer values that refer to activities with the activity labels (Step 3)
•	Melts data to four columns so that each row contains a subject, an activity, a variable, and an observed value
•	Creates a second, tidy dataset that summarizes the melted data so that each row contains a single average observed value for each subject/activity/variable
•	Exports the tidy dataset to a text file
