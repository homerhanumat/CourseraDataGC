# Steps for getting the data are described in GettingData.R, in this repo.
# I renamed the downloaded and unzipped directory UCI_HAR_Dataset.

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

# Check to see if any names are duplicated
duplicatedNames <- unique(measNames[duplicated(measNames)])
# yikes, many of them ARE duplicatred!

# Let's make a table of the repeated names:
namesSelected <- measNames[measNames %in% duplicatedNames]
tab <- as.matrix(table(namesSelected))
colnames(tab) <- "timesOccurring"
tab

# Could it be that columns for identical names contain identical measurements?
# If so, then we could delete spurious columns from the data.

# To check this, we build a small data frame consisting of the columns
# whose names are repeated.
colsSelected <- x[measNames %in% duplicatedNames]
namesSelected <- measNames[measNames %in% duplicatedNames]
names(colsSelected) <- namesSelected

# now check to see if any columns are the same
mat <- t(as.matrix(colsSelected))
# the duplicated() function applied to a data frame checks
# to see if rows are duplicated:
dups <- duplicated(as.data.frame(mat))

# Were there any duplicated rows?
any(dups)
# No!  So we had better keep all of the columns with duplicated names,
# but complain about it in the README.md file.


# Another issue:  some measurment names do not appear in the code book:
bodyDouble <- grep(pattern = "BodyBody", x = measNames, value = TRUE)
bodyDouble

# Do the names with Body not doubled appear?
bodySingle <- gsub(pattern = "BodyBody", replacement = "Body", x = bodyDouble)
length(which(measNames %in% bodySingle))
# They don't!  We should eliminate the doubled "Body" in these names.
measNames <- gsub(pattern = "BodyBody", replacement = "Body", x = measNames)

# Clean the names a bit, replacing all other punctuation with a dot:
measNames <- gsub(pattern = "\\(|\\)", replacement = "", x = measNames)
measNames <- gsub(pattern = "[-,]", replacement = ".", x = measNames)


# add verion tags at the end of each of each duplicated name:
duplicatedCleanNames <- unique(measNames[duplicated(measNames)])
measNamesDistinguished <- measNames
for (dupName in duplicatedCleanNames) {
  places <- which(measNames == dupName)
  for (j in 1:length(places)) {
    measNamesDistinguished[places[j]] <- paste0(measNames[places[j]], ".Version",j)
  }
}

# Finally, we can make the full tidy data frame!
samsung <- cbind(subjects,x,y)
names(samsung) <- c("subject", measNamesDistinguished, "activity")

# Assignment wants the summary frame with the grouped means and grouped sds.
# So, we get the grouped means:
samsungMean <- samsung %>% 
  group_by(subject, activity)  %>%
  summarise_each(funs(mean))

# Then we get the grouped sds:
samsungSD <- samsung %>% 
  group_by(subject, activity)  %>%
  summarise_each(funs(sd))

# Combine them:
samsungBoth <- rbind(samsungMean, samsungSD)

# add a variable to indicate which type of summary is given:
n <- nrow(samsungMean)
summaryType <- c(rep("mean", n), rep("standardDeviation", n))
samsungBoth$summaryType <- summaryType

# reshape to long format:
samsungAVG <- melt(samsungBoth, id.vars = c("subject", "activity", "summaryType"))
names(samsungSD)[4] <- "measurementType"

# Write it to a text file:
write.table(samsungAVG,"samsung.txt", row.names = FALSE)
