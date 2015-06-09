## This block of code gets the data, unpacks, and renames the folder containing the data:


fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url = fileURL, destfile = "samsung.zip", mode = "wb")
unzip(zipfile = "samsung.zip")
file.rename(from = "UCI HAR Dataset", to = "UCI_HAR_Dataset")
