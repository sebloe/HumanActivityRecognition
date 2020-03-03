# HumanActivityRecognition
Analysis of Human Activity using smartphone sensor data

Information about the data set can be found in rawData/README.txt

General information: The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 


The dataset includes the following files:
=========================================

- rawData/ : Folder with experiment data that is transformed. Has its own README.txt to describe the data
- run_analysis.R : Script transforming the data from rawData-folder with R
- CodeBook.md : Description of all variables and summaries calculated
- readme.md
- grouped_means.txt: List of all mean values grouped by Activity and Subject

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each row on the text file represents the means of one subject in one activity.

Process: 
======
- This analysis can be divided in the following parts

1.Import Data
	-Imports Datasets, Activities, Subjects and Labels from rawData-folder
	-combines Test and Training data
2.Data Transformation 
	-Use regular expression to extract columns with mean and standard deviation values
	-give activities descriptive values
	-give appropriate labels to make it more readable
3.Build new dataset
	-Extract all mean-columns
	-build new dataset include the mean of all these columns grouped by activity and subject
	-write new dataset to file grouped_means.txt
4.Clean
	remove all helper data
