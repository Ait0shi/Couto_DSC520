# Assignment: Week4 #1
# Name: Couto, Maria
# Date: 2023-06-30

setwd("C:/Users/ait0s/OneDrive/Documents/GitHub/Couto_DSC520")

# Load the `scores.csv' data set

datasetforscores <- read.csv("scores.csv")
datasetforscores

# What are the observational units in this study?

  # In statistics, observational units are the entities (people,things,etc.)
  # and may sometimes be referred as subject if they are people.
  # In a datafarame,
  # however, every row is considered an observation and every column is a
  # variable. There are 38 rows and 3 columns in this dataset

nrow(datasetforscores)

# Identify the variables mentioned in the narrative paragraph 
#   and determine which are categorical and quantitative?

  # Categorical Variables: sections (sports and variety)
  # Quantitative: course grades and total points earned

# Create one variable to hold a subset of your data set that contains 
#   only the Regular Section and one variable for the Sports Section.

library(plyr)
library(dplyr)
select(datasetforscores, "Section")
regular_section <- filter(datasetforscores, Section == "Regular")
sports_section <- filter(datasetforscores, Section == "Sports")
regular_section
sports_section

# Use the Plot function to plot each Sections scores and 
# the number of students achieving that score. 
# Use additional Plot Arguments to label the graph 
# and give each axis an appropriate label. 


library(ggplot2)
theme_set(theme_minimal())

# Plot each Section (Regular Scatter & Histogram)
ggplot(regular_section, aes(Score, Count)) + 
  geom_point(colour = "green",size = 3) +
  ggtitle("Plot: Regular Section")

ggplot(regular_section, aes(y=Count,x=Score)) +
  geom_bar(position = 'dodge', stat='identity',colour="black",fill="green") +
  ggtitle("Bar: Regular Section")

# Plot each Section (Sports Scatter & Histogram)

ggplot(sports_section, aes(Score, Count)) +
  geom_point(colour = "blue",size = 3) +
  ggtitle("Plot: Sports Section")

ggplot(sports_section, aes(y=Count,x=Score)) +
  geom_bar(position = 'dodge', stat='identity',colour="black",fill="blue") +
  ggtitle("Bar: Sports Section")


# Comparing and contrasting the point distributions between the two section, 
# looking at both tendency and consistency: Can you say that one section tended 
# to score more points than the other? Justify and explain your answer.
  # we can see that the regular section has a tendency to score more.
  # the bar chart for the regular section is unimodal with one peak and
  # has a distribution that is left -skewed. Meaning, more participants
  # scored higher and the lower tail is longer on the left side.
  # The sports section,on the other hand, has a bimodal distribution with two 
  # distinct peaks and has multiple modes where different values
  # appear more in the dataset. 
  

# Did every student in one section score more points than every student 
# in the other section? If not, explain what a statistical tendency means 
# in this context.
# For this question, I plotted the values of both sections side by side
# to show the comparison between the two. The visuals show us
# that the sports section has both the highest and the lowest score
# in the dataset. So not every student in one section score more
# point than the other. Rather, the scores are more distributed
# between the two sections. Statistical tendency helps us
# describe a dataset by showing the frequency of the distribution of the
# observations. The charts help us see the mode or the frequency of the
# occurence in each data points. The graph shows that in the regular section,
# the data points gravitate toward the higher end of the x axis which is a good
# indicator that the regular section, overall, scored higher points than the 
# sports section.

#Side-by_Side Plot comparison for Regular and Sports Section

ggplot(datasetforscores, aes(x=Score,y=Count,colour=Section)) +
  geom_point(size = 2) +
  scale_color_manual(values = c("Regular"="green","Sports"="blue"))

#Side-by_Side Bar comparison for Regular and Sports Section


ggplot(datasetforscores, aes(fill=Section,y=Count,x=Score)) +
  geom_bar(position = 'dodge', stat='identity')

# What could be one additional variable that was not mentioned 
# in the narrative that could be influencing the point distributions 
# between the two sections
# On the narrative- it speaks to  course grades and total points 
# earned in the course as the quantitative value. However, the columns
# in the dataset shows counts, scores, and section. I'm assuming then, 
# that the count refers to the number of students who achieved the score
# and their respective sections for each row. For example, does
# gender play a role on whether or not a student would choose
# to go to a course exclusive to sports application? While there are a lot of
# variables that could affect the score, I would also be interested in 
# seeing the grades if the students prior to the professor teaching
# the section. This would tell us if students who tend to perform better
# has a tendency to enroll in the sports section or would they prefer to be
# given a variety of application areas when they are learning their
# lesson. 




