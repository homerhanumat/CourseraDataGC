# Notes for Evaluators of This Assignment

The required data frame can be downloaded from the Coursera site.  You can read it in using the following R command (assuming you have it in your working directory):

```
samsung <- read.table("samsung.txt", header = TRUE)
```

There were 30 subjects.  Each performed all of 6 possible activities several times.  During each performance of a particular activity, 66 of the 561 types of measurement made on the subject were determined to be of interest for the purposes of this assignment (see the code book for details).  The data set provided on the Coursera site records the mean for measurment of interest.

The number of combinations of thirty subjects, six activities and 66 types of measurement is:

> 30 x 6 x 66 = 11880.

Each row in the dataset corresponds to one of these combinations.  Hence there are 11880 rows in the data set.

There are four columns:

* **subject**:  the id number of the subject
* **activity**:  the activity being performed by the subject
* **feature**: the measurement of interest
* **mean**:  mean of the given, measurement of interest, taken over all instances in which the given subject performed the given activity.

Thus it's a tidy data set, albeit in long format.

Consult the `run_analysis.R` script in this repo to learn how I made the `samsung.txt` file.  I have provided reasonably detailed comments for each step.  You can consult the file `codebook.md` for a detailed account of the names for the different types of measurements that were made on each subject.

I would like to remark upon one issue that I ran into along the way.  In the original data, some measurement-type names had a typo: the phrase "BodyBody" appears, whereas in the code book for the original data it would seem that only "Body" was intended. I removed the extra "Body" from such names.
