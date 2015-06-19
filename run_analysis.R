# Steps for getting the data are described in GettingData.R, in this repo.
# (I renamed the downloaded and unzipped directory UCI_HAR_Dataset.)

# load some packages:
library(plyr)
library(dplyr)
library(reshape2)


# read in training and test subjects
subjectsTrain <- read.table("UCI_HAR_Dataset/train/subject_train.txt")
subjectsTest <- read.table("UCI_HAR_Dataset/test/subject_test.txt")

# combine them
subjects <- rbind(subjectsTrain, subjectsTest)
names(subjects) <- "subject"

# read in phone measurments and activities for test subjects: and for training subjects
xtest <- read.table("UCI_HAR_Dataset/test/X_test.txt", header = F)
ytest <- read.table("UCI_HAR_Dataset/test/y_test.txt", header = F)
xtrain <- read.table("UCI_HAR_Dataset/train/X_train.txt", header = F)
ytrain <- read.table("UCI_HAR_Dataset/train/y_train.txt", header = F)

# combine them
y <- rbind(ytrain, ytest) # activities for all subjects
x <- rbind(xtrain, xtest) # phone measurments for all subjects

names(y) <- "activity"

# recode activities to descriptive values
y <- y %>% transmute(activity = plyr::mapvalues(activity,
                                     from = c(1:6),
                                     to = c("walking", "walking_upstairs", "walking_downstairs",
                                            "sitting","standing","laying")))


# read in the names for the phone measurments
connection <- file("UCI_HAR_Dataset/features.txt", "r")
measNames <- readLines(con = connection)
close(connection)

# remove spurious row numbers at beginning of each line
measNames <- gsub(pattern = "^.* ", replacement = "", x = measNames)

# Another issue:  some measurment names do not appear in the code book:
bodyDouble <- grep(pattern = "BodyBody", x = measNames, value = TRUE)
bodyDouble

# Do the names with Body not doubled appear?
bodySingle <- gsub(pattern = "BodyBody", replacement = "Body", x = bodyDouble)
length(which(measNames %in% bodySingle))
# They don't!  We should eliminate the doubled "Body" in these names.
measNames <- gsub(pattern = "BodyBody", replacement = "Body", x = measNames)

# we need only the names that indicate computationof mean or standard
# deviation:  "-mean()" or "-std()" according to the codebook:
neededNames <- grepl(pattern = "-((mean)|(std))\\(\\)", x = measNames)

# I noticed that of the original 561 features, some of the names were duplicated.
# Is this the case for the ones we need?
sum(duplicated(measNames[neededNames]))
# no duplications, good!

# Given my ignorance of physics, I'd better not try to make any of the feature
# names "more descriptive".

# Finally, we can make the full tidy data frame!
# select only the features that we need:
xSmall <- x[,which(neededNames)]
samsung <- cbind(subjects,xSmall,y)
names(samsung) <- c("subject", measNames[neededNames], "activity")

# Assignment wants the summary.
# So, we get group by subject and activity, then take means over the groups:
samsungMean <- samsung %>% 
  group_by(subject, activity)  %>%
  summarise_each(funs(mean))

# I like a long format, here:
samsungAVG <- melt(samsungMean, id.vars = c("subject", "activity"))
# make column names more descriptive
names(samsungAVG)[3] <- "feature"
names(samsungAVG)[4] <- "mean"


# Write it to a text file:
write.table(samsungAVG,"samsung.txt", row.names = FALSE)

# prepare list of feature names for codebook:
mydf <- data.frame(feature = measNames[neededNames])
mydf