## data_analysis function
# expects to run in base directory with subdirectory "UCI HAR Dataset" containing "test" and "train" directories
#    of the necessary data
#
# 'output.txt' is created in the current directory and is the required tidy data
# no inputs
# return value is the tidy data table
#
run_analysis <- function()  {
    ## merge data: test + training
    ## extracts mean stdev for each
    ## uses desc activity names to name activities
    ## Approp labels data set
    ## Creates a second tidy data set with average of each variable for each activity and each subj

    ## Pertinent files
    file_test_sub<-".\\UCI HAR Dataset\\test\\subject_test.txt"
    file_test_x<-".\\UCI HAR Dataset\\test\\X_test.txt"
    file_test_y<-".\\UCI HAR Dataset\\test\\y_test.txt"
    file_train_sub<-".\\UCI HAR Dataset\\train\\subject_train.txt"
    file_train_x<-".\\UCI HAR Dataset\\train\\X_train.txt"
    file_train_y<-".\\UCI HAR Dataset\\train\\y_train.txt"

    file_act_labels<-".\\UCI HAR Dataset\\activity_labels.txt"
    file_features<-".\\UCI HAR Dataset\\features.txt"
   
    ## read in data
    data_test_sub<-read.table(file_test_sub)
    data_test_x<-read.table(file_test_x)
    data_test_y<-read.table(file_test_y)
    data_train_sub<-read.table(file_train_sub)
    data_train_x<-read.table(file_train_x)
    data_train_y<-read.table(file_train_y)
    
    data_act_labels<-read.table(file_act_labels,sep=" ")
    data_features<-read.table(file_features,sep=" ")
    
#     dim(data_test_sub)
#     dim(data_test_x)
#     dim(data_test_y)
#     dim(data_train_sub)
#     dim(data_train_x)
#     dim(data_train_y)
#     dim(data_act_labels)
#     dim(data_features)
 
    ## set up and assign column labels
    feature_names<-data_features[,2]
    names(data_train_x)<-feature_names
    names(data_test_x)<-feature_names
    names(data_test_sub)<-c("Subject")
    names(data_train_sub)<-c("Subject")
    names(data_test_y)<-c("TrainingLabel")
    names(data_train_y)<-c("TrainingLabel")
    names(data_act_labels)<-c("V1","TrainingLabel")

    ## combine data for each individual group/ test and train
    train<-cbind(data_train_sub,data_train_y,data_train_x)
    test<-cbind(data_test_sub,data_test_y,data_test_x)
    
    # mean and std columns, identify, combine, sort, and offset by 2 in cbind data.frames
    i<-grep("mean\\(",feature_names)
    j<-grep("std\\(",feature_names)
    k<-sort(c(i,j))
    k<-k+2
    k<-c(1,2,k)

    # limit test and train to mean/std columns
    ltrain<-train[k]
    ltest<-test[k]

    ## swap out the labels of column 2 with the desc names, act_labels
    ltrainl<-merge(data_act_labels,ltrain,by.y="TrainingLabel",by.x="V1")
    ltestl<-merge(data_act_labels,ltest,by.y="TrainingLabel",by.x="V1")

    finalData<-rbind(ltrainl,ltestl)
    
    #final tidy data set
    m<-melt(finalData,id=c("TrainingLabel","Subject"),measure.vars=names(finalData[4:dim(finalData)[2]]))
    mFinal<-dcast(m,TrainingLabel + Subject ~variable,mean)

    write.table(mFinal,"output.txt",sep=" ")
    mFinal
}

    