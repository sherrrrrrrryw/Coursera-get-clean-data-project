The `run_analysis.R` performs data cleaning following the steps described below:

**1. Download the dataset**

Download the datafile as `Dataset.zip` and store in the folder `wk4`. The downloaded file is unzipped under the folder called `UCI HAR Dataset`.

**2. Assign the variables**

`feature` <- `features.txt`: the txt file includes 561 rows and 2 columns.  
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

`activities` <- `activity_labels.txt`: the txt file includes 6 rows and 2 columns.  
This file describes the activities performed and their codes.

`subject_test` <- `subject_test.txt`: the txt file includes 2947 rows and 1 column.  
This dataset is the test data of the subjects.

`subject_train` <- `subject_train.txt`: the txt file includes 7352 rows and 1 column.  
This dataset is the train data of the subjects.

`x_test` <- `X_test.txt`: the txt file includes 294 rows and 561 columns.  
This file describes the recorded features of the test data.

`x_train` <- `X_train.txt`: the txt file includes 7352 rows and 561 columns.  
This file describes the recorded features of the train data.

`y_test` <- `y_test.txt`: the txt file includes 2947 rows and 1 column.  
This file describes the activity codes of the test data.

`y_train` <- `y_train.txt`: the txt file includes 7352 rows and 1 column.  
This file describes the activity codes of the train data.

**3. Merge the training and the test datasets to create one dataset**

`X` <- Merge `x_train` and `x_test` with **rbind()** function. This new dataset includes 10299 rows and 561 columns.  
`Y` <- Merge `y_train` and `y_test` with **rbind()** function. This new dataset includes 10299 rows and 1 column.    
`Subject` <- Merge `subject_train` and `subject_test` with **rbind()** function. This new dataset includes 10299 rows and 1 column.  
`Merged` <- Merge `Subject`, `X`, and `Y` with **cbind()** function. This new dataset includes 10299 rows and 563 columns.

**4. Extract only the measurements on the mean and standard deviation for each measurement**

`TidyData` <- Subset `Merged` by selecting the columns: `subject`, `code`, and the measurements on the `mean` and `std` only. This new dataset includes 10299 rows and 88 columns.    

**5. Uses descriptive activity names to name the activities in the data set**
Replace the activity code in `TidyData` with the corresponding activity name.

**6. Appropriately labels the data set with descriptive variable names**
Rename the abbreviated variable names with descriptive ones.  
`Acc` is renamed as `Accelerometer`
`Gyro` is renamed as `Gyroscope`
Column names start with `t` are renamed as `Time`
Column names start with `f` are renamed as `Frequency`
`Bodybody` is renamed as `Body`
`Mag` is renamed as `Magnitude`
Column names end with `freq()` are renamed as `Frequency`
Column names end with `mean()` are renamed as `Mean`
Column names end with `std()` is renamed as `STD`

**7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**
`CalData` <- Summarise `TidyData` to obtain the mean of `TidyData` after grouping with `subject` and `activity`. This calculated new dataset has 180 rows and 88 columns.  
`Final.txt` <- Export `CalData` into `Final.txt` file.
