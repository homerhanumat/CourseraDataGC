# Notes for Evaluators of This Assignment

The required data frame can de downloaded from the Coursera site.  You can read it in using the following R command (assuming you have it in your working directory):

```
samsunAVG <- read.table("samsungAVG.txt", header = TRUE)
```

It's tidy:

* Each row refers to a particular subject performing a particular activity.  
* Each column gives the mean of all phone measurements of a particular type that were made on the subject while he/she was performing that particular activity.

Consult the `run_analysis.R` script in this repo to learn how I made the `samsungAVG` data frame:  I have provided reasonably detailed comments for each step.  You can consult the file `codebook.md` for a detailed account of the variable names.

Here are some issues I ran into along the way:

* In the original data, some variable names had a typo:  the phrase "BodyBody" appears, whereas in the code book for the original data it would seem that only "Body" was intended.  I removed the extra "Body" from such names.
* The original variable names were fairly descriptive, but they had some punctuation (parentheses and dashes) that I thought might cause problems for R users who want to analyse the data further.  I replaced all such punctuation with dots.
* I noticed that some variable names were duplicated (i.e., quite a few columns of data had exactly the same variable name).  Columns sharing the same variable name did not contain identical data, so I did not think it wise to delete any columns.  Instead I added a tag at the end of each duplicated name to distinguish it from its duplicates.  See the code book for more detail on the matter, and for my tagging convention.
