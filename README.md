#coursera
Final Project
##A few words from the author/student/participant/victim
Thank you for taking the time to review this project :grinning:. You probably 
have other commitments attend to, yet you are reading this and reviewing my 
project.
Thank you for doing that.

###List of Files in the Repo:
1. *final.r* 
  - The R script that describes the transformations I have applied.
  - Comments have been added as well.
2. *Codebook.md*
  - This document describes the names given to the column, and the units of measurement.
3. *TidiedHumanActivity.txt*
  - This text file contains the Tided data file.
  - The operations of *final.r* have beeen applied to the training and test data, available at [this link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
  

###Operating on the files
- *final.r* 
  - To run this file, the directory one ought to be in the folder that houses the test and train folders.
  - *Thus the dataset must have been downloaded and extracted alread.)
  - On my computer, the extracted folder "UCI HAR Dataset" is where my working directory lies.
```
      > getwd()
      [1] "C:/Users/user/Documents/RFiles/project/UCI HAR Dataset")
```
  - Required attached libraries:
    - data.table
    - dplyr
- *TidiedHumanActivity.txt*
  - To read this file in:
```
data <- read.table(file = "TidiedHumanActivity.txt", header = T)
View(data)
```
  
###Tidy Data
  - To the best of my ability, the tidied data file *TidiedHumanActivity.txt* follows the guidelines of what constitues to be tidy data.
  - **A possible explanation:** Since the task asked us to fing out the averages of all of the mean and standard deviation variables per activity and per person, and since there exists 30 participants for each of the 6 activities, there will exist 180 different observations. Initially, I was perturbed to see 180 observations while I assumed to have only 30 observations. But, since we are required to find the averages accross 6 activities, 30 participants * 6 activities = 180 observations makes sense. This gave me a sense of relief.
  
###Sources that have been used:
  - David Hood's guidelines on cleaning data. [Link](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment)
  - Stack Overflow
