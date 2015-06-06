# Notes for Evaluators of This Assignment

The required data frame can be downloaded from the Coursera site.  You can read it in using the following R command (assuming you have it in your working directory):

```
samsunAVG <- read.table("samsungAVG.txt", header = TRUE)
```

There were 30 subjects.  Each performed all of 6 possible activities several times.  During each performance of a particular activity, 561 types of measurement were made on the subject.  The data set provided here records two summaries of each type of measurement:

* the mean over all performances of the given activity by the given subject
* the standard deviation over all performances of the given activity by the given subject 

Thirty subjects, six activities, 561 types of measurement, two summaries for each type gives

> 30 x 6 x 561 x 2 = 201960.

Hence there are 201960 rows in the data set.

There are five columns:

* **subject**:  the id number of the subject
* **activity**:  the activity being performed by the subject
* **summaryType**: type of numerical summary (mean or sd)
* **variable**:  type of phone measurement that is being summarized
* **value**:  numerical value of the summary (the value of the mean or the sd)

Thus it's a tidy data set, albeit in long format.

Consult the `run_analysis.R` script in this repo to learn how I made the `samsungAVG` data frame:  I have provided reasonably detailed comments for each step.  You can consult the file `codebook.md` for a detailed account of the names for the different types of measurements that were made on each subject.

Here are some issues I ran into along the way:

* In the original data, some measurement-type names had a typo:  the phrase "BodyBody" appears, whereas in the code book for the original data it would seem that only "Body" was intended.  I removed the extra "Body" from such names.
* The original measurement-type names were fairly descriptive, but they had some punctuation (parentheses and dashes) that I thought might cause problems for R users who want to analyse the data further.  I replaced all such punctuation with dots.
* I noticed that some measurement-type names were duplicated (i.e., quite a few columns of in the original data had exactly the same measurement-type name.  Columns sharing the same variable name did not contain identical data, so I did not think it wise to delete any of this data.  Instead I added a tag at the end of each duplicated name to distinguish it from its duplicates.  See the code book for more detail on the matter, and for my tagging convention.
