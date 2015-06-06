# Codebook

**Note:  this document is adapted from `features_info.txt` file provided with the original data.**

The features selected for the dataset `samsungAVG.txt` come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk.XYZ, fBodyGyro.XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'.XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc.XYZ
* tGravityAcc.XYZ
* tBodyAccJerk.XYZ
* tBodyGyro.XYZ
* tBodyGyroJerk.XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc.XYZ
* fBodyAccJerk.XYZ
* fBodyGyro.XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean: Mean value
* std: Standard deviation
* mad: Median absolute deviation 
* max: Largest value in array
* min: Smallest value in array
* sma: Signal magnitude area
* energy: Energy measure Sum of the squares divided by the number of values. 
* iqr: Interquartile range 
* entropy: Signal entropy
* arCoeff: Autorregresion coefficients with Burg order equal to 4
* correlation: correlation coefficient between two signals
* maxInds: index of the frequency component with largest magnitude
* meanFreq: Weighted average of the frequency components to obtain a mean frequency
* skewness: skewness of the frequency domain signal 
* kurtosis: kurtosis of the frequency domain signal 
* bandsEnergy: Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle: Angle between to vectors.

In all, 561 types of measurments were mad eon each subject.  For reasons I do not know, some measurment names in the data as described above are *duplicated*.  Here is a table of the duplicated names, showing that each was duplicated three times:

```
                                 timesOccurring
fBodyAcc-bandsEnergy()-1,16                   3
fBodyAcc-bandsEnergy()-1,24                   3
fBodyAcc-bandsEnergy()-17,24                  3
fBodyAcc-bandsEnergy()-17,32                  3
fBodyAcc-bandsEnergy()-1,8                    3
fBodyAcc-bandsEnergy()-25,32                  3
fBodyAcc-bandsEnergy()-25,48                  3
fBodyAcc-bandsEnergy()-33,40                  3
fBodyAcc-bandsEnergy()-33,48                  3
fBodyAcc-bandsEnergy()-41,48                  3
fBodyAcc-bandsEnergy()-49,56                  3
fBodyAcc-bandsEnergy()-49,64                  3
fBodyAcc-bandsEnergy()-57,64                  3
fBodyAcc-bandsEnergy()-9,16                   3
fBodyAccJerk-bandsEnergy()-1,16               3
fBodyAccJerk-bandsEnergy()-1,24               3
fBodyAccJerk-bandsEnergy()-17,24              3
fBodyAccJerk-bandsEnergy()-17,32              3
fBodyAccJerk-bandsEnergy()-1,8                3
fBodyAccJerk-bandsEnergy()-25,32              3
fBodyAccJerk-bandsEnergy()-25,48              3
fBodyAccJerk-bandsEnergy()-33,40              3
fBodyAccJerk-bandsEnergy()-33,48              3
fBodyAccJerk-bandsEnergy()-41,48              3
fBodyAccJerk-bandsEnergy()-49,56              3
fBodyAccJerk-bandsEnergy()-49,64              3
fBodyAccJerk-bandsEnergy()-57,64              3
fBodyAccJerk-bandsEnergy()-9,16               3
fBodyGyro-bandsEnergy()-1,16                  3
fBodyGyro-bandsEnergy()-1,24                  3
fBodyGyro-bandsEnergy()-17,24                 3
fBodyGyro-bandsEnergy()-17,32                 3
fBodyGyro-bandsEnergy()-1,8                   3
fBodyGyro-bandsEnergy()-25,32                 3
fBodyGyro-bandsEnergy()-25,48                 3
fBodyGyro-bandsEnergy()-33,40                 3
fBodyGyro-bandsEnergy()-33,48                 3
fBodyGyro-bandsEnergy()-41,48                 3
fBodyGyro-bandsEnergy()-49,56                 3
fBodyGyro-bandsEnergy()-49,64                 3
fBodyGyro-bandsEnergy()-57,64                 3
fBodyGyro-bandsEnergy()-9,16                  3
```

Interestingly, for each of the duplicated names the three columns of measurements are distinct from one another.  Hence I decided to treat such measurments as three distinct measurement types, and to distinguish their names by appending a "version tag".  Thus, the second occurence of the measurment-type `fBodyGyro-bandsEnergy()-9,16` appears in the data frame as:

> `fBodyGyro-bandsEnergy()-9,16.Version2`


The variables in the data set are as follows:

* **subject**:  the ID number assigned to each subject in the study.
* **activity**:  the activity performed by each subjects when the measurments were being made.  Possible values are:
    * walking
    * walking_upstairs
    * walking downstairs
    * sitting
    * standing
    * laying
* **summaryType**: type of numerical summary to be given.  Possible values are:
    * mean
    * standardDeviation
* **variable**:  type of phone measurement that is being summarized.  There are 561 possible types, as described above.
* **value**:  the numerical value of the summary (the value of the mean or the sd)

The `samsungAVG.txt` data file shows the mean and the standard deviation of each of the 561 types of measurements, for each subject for each activity.
