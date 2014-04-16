run_analysis.R Explanation
=================================
The script, run_analysis.R, takes the Samsung Galaxy accelerometer data provided to the class and both cleans and condenses it, by doing the following: 

1. Reads-in the feature.txt file (which contains the names of the variables) and stores it as *feature*
2. Selects the names in *feature* which are either a mean or a standard deviation and stores their positions in *colneeded*
3. Using the *colneeded* vector, run_analysis.R creates a vector comprised of "NULL"s and "numeric"s based on which columns we will want to ignore or read-in respectively
4. Stores the data we want from the **test data** using the read.table function and the colClasses specification
5. Adds a row for both the test subject number and the activity they performed
6. Repeats steps 4 & 5 for the **training data** and then combines the two data frames into *comdf*
7. Renames the columns of *comdf* for clarity and orders the data frame by subject and then activity
8. Replaces the numbers representing each activity with the name of each activity for added clarity
9. Condenses the data by averaging variables which share a subject and activity *(e.g. If there were originally 10 reported tBodyAcc-mean()-X values for the 19th subject while walking downstairs, those 10 rows would be condensed into 1 row with the mean of the 10 reported)*
10. Finally run_analysis.R writes the condensed and tidy data to a .csv file

Voilà!
