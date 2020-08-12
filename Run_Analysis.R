X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
merged_data <-cbind(Subject, Y, X) 
Tidy_Data <- merged_data %>% select(subject,code,contains("mean"),contains("std"))
Tidy_Data$code <- activities[Tidy_Data$code, 2]
names(Tidy_Data)[2] = "activity"
names(Tidy_Data)<-gsub("Acc", "Accelerometer", names(Tidy_Data))
names(Tidy_Data)<-gsub("Gyro", "Gyroscope", names(Tidy_Data))
names(Tidy_Data)<-gsub("BodyBody", "Body", names(Tidy_Data))
names(Tidy_Data)<-gsub("Mag", "Magnitude", names(Tidy_Data))
names(Tidy_Data)<-gsub("^t", "Time", names(Tidy_Data))
names(Tidy_Data)<-gsub("^f", "Frequency", names(Tidy_Data))
names(Tidy_Data)<-gsub("tBody", "TimeBody", names(Tidy_Data))
names(Tidy_Data)<-gsub("-mean()", "Mean", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data)<-gsub("-std()", "STD", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data)<-gsub("-freq()", "Frequency", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data)<-gsub("angle", "Angle", names(Tidy_Data))
names(Tidy_Data)<-gsub("gravity", "Gravity", names(Tidy_Data))
FinalInfo<-Tidy_Data %>%
  group_by(Subject, activity) %>%
  summarise_all(funs(mean))  
write.table(FinalInfo,"Finaldata.txt", row.name=FALSE)
str(FinalInfo)
