fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url = fileURL, destfile = "samsung.zip")
system("unzip samsung.zip")
# renamed the directory "UCI_HAR_Dataset"
