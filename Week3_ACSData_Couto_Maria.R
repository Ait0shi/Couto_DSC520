# For this assignment, you will need to load and activate the ggplot2 package.
# The syntax for installation is install.packages("ggplot2")
# Upon checking the package is already installed

system.file(package='ggplot2')
library(ggplot2)
theme_set(theme_minimal())

# What are the elements in your data (including the categories and data types)?
# First, I would set my wd to the DSC520 folder
getwd()
setwd("C:/Users/ait0s/OneDrive/Documents/Github/dsc520/data")


# load the 2014 American Community Survey
acs_dataset <- read.csv("acs-14-1yr-s0201.csv")

# What are the elements in your data (including the categories and data types)?
# inspect dataset
head(acs_dataset,10)

#ID - Qualitative/Categorical Data, Nominal Variable, string/character
#ID2 - Qualitative/Categorical Data, Nominal Variable, integer
#Geography - Qualitative/Categorical Data, Nominal Variable, string/character
#POP GROUP ID - Qualitative/Categorical Data, Nominal Variable, integer
#POPGROUP.display.label - Qualitative/Categorical Data, Nominal Variable, 
#                         string/character
#RacesReported - Quantitative, Discrete, Count, int
#HSDegree - Quantitative, Continuous, num
#BachDegree - Quantitative, Continuous, num


# Please provide the output from the following functions: str(); nrow(); ncol()
str(acs_dataset)
nrow(acs_dataset)
ncol(acs_dataset)

# Create a Histogram of the HSDegree variable using the ggplot2 package.
# Set a bin size for the Histogram.
# Include a Title and appropriate X/Y axis labels on your Histogram Plot.

acs_hist <-ggplot(acs_dataset, aes(HSDegree)) + 
  geom_histogram(aes(y= ..density..), bins = 10) +
  ggtitle("2014 American Community Survey Data") + 
  labs(x ="High School Degree (%)", y="Count of (%)")

acs_hist

# Answer the following questions based on the Histogram produced:
#
# Based on what you see in this histogram, is the data distribution unimodal?
#   -- Unimodal distribution in statistics shows only one clear peak. (90)
#
# Is it approximately symmetrical?
#   -- the data is not symmetrical. It is left-skewed
#
# Is it approximately bell-shaped?
#   -- no. data with a normal distribution will be bell-shaped
#
# Is it approximately normal?
#  -- normal distributions are unimodal like this data. However, the histogram
#  is skewed and the results are clustered towards the high end. 
#
# If not normal, is the distribution skewed? If so, in which direction?
#  -- the distribution was left-skewed which means it is negatively skewed.
# 
# Include a normal curve to the Histogram that you plotted.

acs_hist +
  stat_function(fun = dnorm, args=list(mean=mean(acs_dataset$HSDegree), 
  sd=sd(acs_dataset$HSDegree,na.rm = TRUE)),colour = "blue", linewidth = 2)


# Create a Probability Plot of the HSDegree variable.
install.packages("qqplotr")
library(qqplotr)

prob_plot_HSDegree <- ggplot(acs_dataset, aes(sample = HSDegree))
prob_plot_HSDegree + stat_qq_point(size = 2) + stat_qq_line(color = "green")

# Based on what you see in this probability plot, 
# is the distribution approximately normal? Explain how you know.
# -- the probability plot shows normal distribution if the 
#     actual values follow the line as the values of a normal distribution
#     which will show us a diagonal straight line. In our plot, the distribution
#     shows our actual values deviate from the (green) diagonal line.
# If not normal, is the distribution skewed? 
# -- a qqplot shows skewness if the sample data curves away from the diagonal
#     straight line as shown in the HSDegree plot
# If so, in which direction? Explain how you know.
# -- The probability plot shows the same outcome as the histogram which shows
#     negatively skewed. In the probability plot, we see data values deviating 
#     away from the diagonal

# Now that you have looked at this data visually for normality, 
# you will now quantify normality with numbers using the stat.desc() function. 
# Include a screen capture of the results produced.

install.packages("pastecs")
library(pastecs)
round(stat.desc(acs_dataset$HSDegree, basic = FALSE, norm = TRUE),
digits = 2)


# In several sentences provide an explanation of the result 
# produced for skew, kurtosis, and z-scores.
# -- In a normal distribution, the values of skew & kurtosis would be equal to 0.
#    the output of stat.desc() function shows the skewness of our data to determine
#    the symmetry in the distribution of our data. We can interpret the negative 
#    value (-1.67) as our data piling more towards the higher value,
#    affirming the left tail of our histogram
#    Kurtosis, on  the other hand shows the measure
#    of the tails/outliers in the data. A positive score of 4 shown in kurtosis 
#    tells us that our data has frequent outliers than expected in a normal distribution.
#    Finally, These scores can be converted to obtain a z-score. A value we use to
#    test the significance of the skew and curtosis values we obtained from the data. 
# 
# In addition, explain how a change in the sample size may change your explanation?
# -- A change in the sample size, specifically a larger sample size may deem the
#    the output of the skew and kurtosis to be insignificant as we check for normality
#    The central limit theory tells us that if the sample size is large in relation
#    to the population, it will have a tendency to show a normal distribution. So if
#    we are depending on the skew and kurtosis to determine if our data is normal or
#    not normal and we try to compare it to a value that is already normalized, it
#    will not provide conclusive evidence to the result of our statistic analysis.