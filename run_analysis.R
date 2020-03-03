#Import Data
  #Datasets
  
    trainingData <- read.csv("./rawData/train/X_train.txt", sep="", header = FALSE)
    testData <- read.csv("./rawData/test/X_test.txt", sep="", header = FALSE)
  
  #Create new Dataframe from both datasets
    allData <- rbind(testData,trainingData)
  
  #activities
  
    training_activities <- read.csv("./rawData/train/y_train.txt", header=FALSE)
    test_activities <- read.csv("./rawData/test/y_test.txt", header=FALSE)
  
  #Create combined dataframe
    all_activities <- rbind(test_activities,training_activities)
  
  #subject
  
    training_subj <- read.csv("./rawData/train/subject_train.txt", header=FALSE)
    test_subj <- read.csv("./rawData/test/subject_test.txt", header=FALSE)
  
  #Create combined dataframe
    all_subj <- rbind(test_subj,training_subj) 
  
  #Labels
  
    data_featurelabels <- read.csv("./rawData/features.txt", sep="", header = FALSE)
  
  #isolate values
    data_featurelabels = data_featurelabels$V2
  
    names(allData) <- data_featurelabels
  
  
#Extract Columns with mean and std-deviation

  #Means are identified by "mean()", Std-Deviation is identified by "std()"
  #Only includes means from measurement
    datafilter <- grep("mean()|std()",names(allData))
    mean_std_Data <- allData[datafilter]

#Transform numbers in descriptive values
  all_activities$V1 <- sub("1","WALKING",all_activities$V1)
  all_activities$V1 <- sub("2","WALKING_UPSTAIRS",all_activities$V1)
  all_activities$V1 <- sub("3","WALKING_DOWNSTAIRS",all_activities$V1)
  all_activities$V1 <- sub("4","SITTING",all_activities$V1)
  all_activities$V1 <- sub("5","STANDING",all_activities$V1)
  all_activities$V1 <- sub("6","LAYING",all_activities$V1)

#Add activities
  mean_std_Data$activity = all_activities[[1]]

#Add subjects to each record  
  mean_std_Data$subject = all_subj[[1]]

#Give appropriate labels by specifying Accerlerometer and Gyroscope
  names(mean_std_Data) <- sub("Acc","Accerlerometer",names(mean_std_Data))
  names(mean_std_Data) <- sub("Gyro","Gyroscope",names(mean_std_Data))


#Build new dataset


  #take all means
    filter_mean <- grep("mean()",names(mean_std_Data))
    mean_data <- mean_std_Data[filter_mean] 
  
  #append activity/subject again
  
    mean_data$activity = all_activities[[1]]
    mean_data$subject = all_subj[[1]]
  
  #grouped by activity and subject
    library(dplyr)
    grouped_means <- mean_data %>% group_by(subject,activity) %>% summarise_all(.funs=mean)
  #write grouped means to file
    write.table(grouped_means,file="grouped_means.txt",row.name=FALSE)
    
    
#remove helper data
    rm(training_activities,training_subj,trainingData,activities,data_featurelabels,filter_mean,datafilter,test_activities,test_subj,testData,all_activities,all_subj)