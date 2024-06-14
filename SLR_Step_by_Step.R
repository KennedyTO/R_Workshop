##### Simple Linear Regression #####

## STEP-BY-STEP GUIDE ##

# This script is designed to provide a step-by-step guide to
# participants who are new to R and are interested in learning
# how to conduct a simple linear regression analysis.


### IN THIS ASSIGNMENT, OUR THEORY IS: ###

# Students from wealthier families tend to have higher 
# science literacy scores. In other words, we hypothesize 
# that WEALTH should predicts student's science literacy.

# OUR MISSION IS TO TEST THIS THEORY USING 
# Simple Linear Regression.


##### Objectives of the Analysis #####

#1 Understand the direction of the relationship
#2 Determine the strength of the relationship
#3 Test the significance of the relationship
#4 Make predictions based on the relationship


### Variables of Interest ###

# X = Wealth (WEALTH): Predictor
# Y = Student's science literacy scores (STU_SCI_LITERACY)
#     Outcome Variable
# ---------------------------------------------------------


#### Step 1: Load the Data ####

# Ensure you have a folder dedicated to this Project and save
# I recommend you save all your files on your desktop for now.

# Set the Working Directory
# Ensure to change the file path to your "local file path".
setwd("/Users/kensuzuki/Desktop/R_Workshop/R Workshop Day3")


# Or you can use "~" to shortcut the file path.
# It works on Windows and Mac.
setwd("~/Desktop/R_Workshop/R Workshop Day3")


# Load the data - Mac Users:
# Ensure to specify your own file path.
dat <- read.csv("~/Desktop/R_Workshop/R Workshop Day3/modified_Data.csv")


# Load the data from a pop-up window
# dat <- read.csv(file.choose()) 


#### Step 2: Explore the Data ####

## Check the first 5 rows to get a glimpse of the data.
head(dat)


# If you want to check 10 rows, you can add "10" after the
# dat.

head(dat, 10)
tail(dat, 11)
str(dat)


# Now, let's get the summary statistics of the dataset. This
# is also to get the glimpse of the data.

# To obtain the summary statistics of the entire dataset,
# use the summary() function and enter the dataset name in
# the parentheses.
summary(dat)


# You can also specify the variable you are interested in
# while obtaining the summary statistics. This is useful
# when you have a large dataset and want to focus on a
# specific variable.


# To obtain a summary of a specific variable, use the "$"
# syntax to specify the variable name.
summary(dat$WEALTH)


# ---------------------------------------------------------
## Task 1 ## (Review of Day 1)

# Use the summary() function to obtain the summary statistics
# of the variable "STU_SCI_LITERACY" (Student's Science 
# Literacy Scores) our outcome variable.


# (Your code here)


# If you obtained the following summary output, you are on 
# the right track!

# Min.   1st Qu.  Median   Mean   3rd Qu. Max. 
# 239.9   353.6   394.6   408.0   458.5   600.0 

# ----------------------------------------------------------

#### My interpretation of the summary: Min & Max ####

# The lowest score is 239.9, and the highest score is 600.0,
# which is quite a wide range of scores. To me it indicates 
# that I have a potentially diverse group of students with
# varying levels of science literacy.

# Using some of the methods we learned on day 1, let's 
# calculate the Min and Max range while assigning an
# object to the Min and Max values.

# The equation is simple: max_score - min_score

# First, assign the Min and Max values to objects using the
# "<-" operator.
min_score <- 239.9
max_score <- 600.0

# calculate the range of the scores and assign the value to
# an object called "min_max_range."
min_max_range <- max_score - min_score

# Print the range of the scores.
print(min_max_range)

# ---------------------------------------------------------
## Task 2 ## (Review of Day 1)

# Let's calculate the 1st and 3rd Quantile range AKA the
# Inter Quartile Range (middle 50%) of the student's 
# science literacy scores.

# Please ensure to assign an "object" per each value so that 
# your final equation is: "Q3 - Q1"

# STU_SCI_LITERACY Summary:
# Min.   1st Qu.  Median   Mean   3rd Qu. Max. 
# 239.9   353.6   394.6   408.0   458.5   600.0 

  
## First step:
# Store the 1st Quartile value and the 3rd Quartile value 
# as objects, Q1 and Q3 using "<-" operator.


## Second step:
# Obtain the IQR by subtracting Q1 from Q3 and assign the 
# the name "IQR_score" with "<-" operator and print 
# the score at the end.

# (Your code here):

print(IQR_score)

# Let's confirm if your answer is correct. R has the built-in
# function "IQR()" to calculate the IQ range (LOL).

IQR(dat$STU_SCI_LITERACY)
# ---------------------------------------------------------


### My interpretation of the Quantiles: ###

# If the IQR (Middle 50%) is large relative to the range of 
# scores, it indicates that the scores are spread out 
# over a wide range. 


### My interpretation of the summary: Mean & Median ###

# - The mean score is 408.0
# - The median score is 394.6

# If the median is less than the mean, the tail is longer 
# on the right side. Therefore, the distribution is positively
# skewed (The distribution has more lower scores).

# Let's confirm this by plotting a histogram

hist(dat$STU_SCI_LITERACY) # Review from day 2


### The other options for Descriptive Statistics: ###

# Use describe() function from the "psych" package to get more 
# detailed statistics. (Review from Day 2)


#Install the package if you haven't done so.
# install.packages("psych") 


# Load the package
library(psych)


# Descriptive statistics of the entire dataset
describe(dat)


# If you have a specific variable(s) in mind, use $ syntax
# to specify the variable name.
describe(dat$WEALTH) 


# Another Methods to get descriptive statistics


# Use "describeBy()" function to get descriptive statistics 
# by a specific group. (Review from Day 2)

# In this case, I want to group by SEX variable in my dataset.
# Use "group = " to specify what variable you want to group by.


describeBy(dat, group = dat$SEX)

# The order of appearance of the group is currently alphabetical.
# You can use the factor() and "level" argument to change 
# the order  


# I want to change order of the group to Male and Female
dat$SEX <- factor(dat$SEX, levels = c("Male", "Female"))  
# or any order you prefer


# ---------------------------------------------------------
## Task 3 ## (Review of Day 2)

# Using the example shown above 

# Drawing from the previous example, group the descriptive
# statistics by the variable "REPEAT".

# This variable shows if a student repeated a grade. 
# With 0 being "No" and 1 being "Yes."


# (Your code here)


# if you see group 0 and group 1 in the output, you are
# on the right track!
# ---------------------------------------------------------

########### Step 3: Clean the Data ############

# Cleaning the data is an essential step in the data analysis.

# It involves:

# 1) Addressing missing values - A very critical operation.
# 2) Changing variable names.
# 3) Changing variable types.
# 4) Changing values from text to number etc., etc.

# To start, let's check the structure of the dataset 
# and find out what needs to be cleaned!

str(dat)

# Notice there is one variable name that does not make a whole
# lot of sense, ST022Q01TA. 

# Referencing the code book provided, this variable represents 
# the "LANGUAGE spoken at home". 

# Let's change the variable name to "LANGUAGE" and let's store
# the cleaned dataset as a separate data, "dat_cleaned".


#### 1) Change the variable name using the Pipe operator ####


# To change the variable name, we will use the pipe operator
# (Review from Day 2) and "rename()" function from dplyr.

# Let's load the package first.

# install.packages("dplyr") # if you haven't done so
library(dplyr)

dat_cleaned <- dat %>% 
  rename(LANGUAGE = ST022Q01TA)


# Check the outcome of the new dataset "dat_cleaned"
str(dat_cleaned)



##### 2) Change the integer variables to numeric variables. #####

# For Linear Regressions function to work properly, 
# ensure that all variables are in the correct data type.

# Outcome Variable:
# Should be "Continuous" and set to "NUMERIC".

# Predictor Variables:
# Should be "Continuous" and set to "NUMERIC" 
# or if they are Categorical, set to "FACTOR".

# Let's check the structure of the dataset again.
# Notice some variables have "int" and "chr" as data types.

# We touched on the types on Day 1 and Day 2
# "num" = numeric 
# "int" = integer 
# "chr" = character  
# "fct" = factor 
# "dbl" = double
# "lgl" = logical
# "dttm" = date-time


# Change Integer values (PARENT_ED and REPEAT) to numeric values
# and save them as new variables (num_PARENT_ED and num_REPEAT)

# The structure of the mutate function is:
# mutate(new_variable_name = as.numeric(old_variable_name))


# Let's do it using the pipe operator
dat_cleaned <- dat_cleaned %>% 
  mutate(num_PARENT_ED = as.numeric(PARENT_ED))


# Check the outcome
str(dat_cleaned)

# ---------------------------------------------------------
## Task 3.1 ##
# Following the example above, change the REPEAT variable to
# a numeric variable and save it under the name num_REPEAT.

dat_cleaned <- dat_cleaned %>% 
  mutate(num_REPEAT = as.numeric(REPEAT))

# Check the outcome
# (Your code here)


# Check the outcome
str(dat_cleaned)

## Task 3.2 ##
# Change SEX variable and LANGUAGE variable to a factor with 
# pipe operator and mutate function and OVERWRITE the existing
# variables.

# The structure of the mutate function is:
# mutate(new_variable_name = as.factor(old_variable_name))


dat_cleaned <- dat_cleaned %>% 
  mutate(SEX = as.factor(SEX),
         LANGUAGE = as.factor(LANGUAGE))


# Check the outcome
str(dat_cleaned)
# ---------------------------------------------------------



#### 3) Addressing Missing Data ####

# Dealing with missing data is extensive and can easily take 
# up an entire workshop on its own. 

# There are several ways to deal with missing data:

# For the time being, we will focus on a simple deletion of
# missing values. This list-wise deletion is only appropriate 
# if the missing values are random. It is the "last resort" 
# and should only be used if you can't find other solutions.


# To find missing values, use the is.na() function.
# sum() function will give you the total number of missing
# values in the dataset.


# Check for missing values
sum(is.na(dat))


# If there are missing values, you can remove rows with NA
dat_cleaned <- na.omit(dat)


# Delete missing values using pipe operator
dat_cleaned <- dat %>% na.omit()


# Check for missing values in the cleaned data
sum(is.na(dat_cleaned))


# Look at the structure of the data
str(dat_cleaned)



##### Step 4: Exploratory Data Analysis (EDA) #####
# EDA is an approach to analyzing data sets to summarize their
# main characteristics, often with visual methods.


# Let's start by looking at the summary statistics of the
# variables of interest: WEALTH and STU_SCI_LITERACY.


# Using pipe operators:
# Fist, you identify the dataset you reference. 
# Next use select() the variables of interest. Finally, use the
# describe() function to get the summary statistics.

dat_cleaned %>% 
  select(WEALTH, STU_SCI_LITERACY) %>% 
  describe()


# Use describe() for WEALTH and STU_SCI_LITERACY individually.
describe(dat_cleaned$WEALTH)
describe(dat_cleaned$STU_SCI_LITERACY)


# You can combine them together as this
describe(dat_cleaned[,c("WEALTH", "STU_SCI_LITERACY")])



# Check for correlation between WEALTH and STU_SCI_LITERACY
cor(dat_cleaned$WEALTH, dat_cleaned$STU_SCI_LITERACY)

# Quick way to make a correlation matrix.
# Ensure that the variables are numeric.
dat_cleaned %>% 
  select(WEALTH, STU_SCI_LITERACY) %>% 
  cor()


# A simple scatter plot (Y = WEALTH, Y = STU_SCI_LITERACY)
plot(dat_cleaned$WEALTH, dat_cleaned$STU_SCI_LITERACY)


# A simple scatter plot with pipe operator
dat_cleaned %>% 
  select(WEALTH, STU_SCI_LITERACY) %>% 
  plot()


# Scatter plot using ggplot2 
library(ggplot2)

# Create a scatter plot with ggplot2 (Y = WEALTH, Y = STU_SCI_LITERACY)

# The ggplot2 package is a popular function for data 
# visualization. The base structure of the ggplot2 function is
# ggplot(data = dataset, aes(x = x_variable, y = y_variable)).
# Using "+" symbol to add layers to the plot.

# Let's make a scatter plot to see the correlation of X and Y.

ggplot(dat_cleaned, aes(x = WEALTH, y = STU_SCI_LITERACY)) + 
  geom_point() + 
  labs(title = "WEALTH and STU_SCI_LITERACY",
       x = "WEALTH",
       y = "STU_SCI_LITERACY") 

# aes() function is used to specify the x and y variables.
# geom_point() function is to create a scatter plot.
# labs() function is to add title and axis labels.


# I often use the GGally package to create a scatter plot matrix
# This package will create a scatter plot matrix with Density
# plot, Scatter plot, and Correlation.

# Use GGally package to create a scatter plot matrix
library(GGally)


# Create a scatter plot matrix with pipe operator
dat_cleaned %>% 
  select(WEALTH, STU_SCI_LITERACY) %>% # Select the variables
  ggpairs() # Create a scatter plot matrix


# What to look for in the plots
# 1) The relationship between the variables
# 2) The distribution of the variables
# 3) The correlation between the variables

# Strength of correlation:
# 0.1 - 0.3: Weak
# 0.3 - 0.5: Moderate
# 0.5 - 1.0: Strong






#### Step 5: Building a Simple Linear Regression (SLR) ####

# The relationship between two variables can be assessed using 
# a SLR model. The simple linear regression model is 
# represented as:

# Y = β0 + β1X + ε

# Where:
# Y is the dependent variable
# X is the independent variable
# β0 is the intercept
# β1 is the slope
# ε is the error term

# The goal of simple linear regression is to estimate the 
# coefficients β0 and β1 that minimize the sum of squared 
# errors.


## Fit a simple linear regression model in R ##
# Use the lm() function to fit a simple linear regression model

# Fit a simple linear regression model
# Structure of the lm() is lm(Y ~ X, data = your data)
set.seed(123) 
SLR_model <- lm(STU_SCI_LITERACY ~ WEALTH, data = dat_cleaned)

# set.seed(...) 
# is used to ensure reproducibility of the results.
# Arithmetic differences like rounding become constant.
# You can enter any number in the set.seed() function.
# Using the same number will give you the same results.

# Check the model
summary(SLR_model)

#### Step 6 Interpretation of the Summary() output: ####

#Residuals:
#  Min       1Q       Median     3Q      Max 
#-165.633  -45.435   -1.262   42.614  182.153 

# The residuals are centered around a median close to zero 
# (-1.262), which is good as it suggests that the model's 
# predictions are, on average, close to the actual values.

# If you are unsure about the distribution of the residuals
# you can plot a histogram of the residuals to check for
# normality with resid() function.


# Save the residual values of SLR model as "residuals_SLR"
residuals_SLR <- resid(SLR_model)


# Plot histogram of the "residuals_SLR"
hist(residuals_SLR)


## Coefficients: ##

# The coefficients table shows the estimated coefficients 
# for the intercept and the slope. In other words, it shows
# the estimated values of β0 and β1.

# The intercept (453.814) is the expected value of Science 
# Literacy when WEALTH is 0.

# The slope (23.610) indicates that for each unit increase in 
# WEALTH, STU_SCI_LITERACY is expected to increase by 23.610 
# units.

# Both coefficients are statistically significant (p < 0.05), 
# indicating a strong relationship between the predictor (WEALTH) 
# and the outcome (STU_SCI_LITERACY).

# You can extract coefficients using the coefficients 
# attributes in the summary() output.
coefficients <- SLR_model$coefficients
print(coefficients)

# Calculate the variances to the mean of STU_SCI_LITERACY
var(dat$STU_SCI_LITERACY)

# Calculate the variances of the residuals
var(residuals_SLR)

# Calculate the R-squared value
R_squared <- 1 - (var(residuals_SLR) / var(dat$STU_SCI_LITERACY))


## Residual Standard Error: ##
#RSE: 69.81 on 94 degrees of freedom.

# The RSE measures the average amount that the response 
# variable deviates from the true regression line. In other words,
# it is the standard deviation of the residuals.
# A lower RSE indicates a better fit.


## R-squared: ##
# Multiple R-squared:  0.1117 (For a single variable)
# Adjusted R-squared:  0.1023 (for Multiple variables)

# The Multiple R-squared (0.1117) indicates that approximately 
# 11.17% of the variability in STU_SCI_LITERACY can be explained 
# by WEALTH. In other words, WEALTH accounts for 11.17% of the
# variability in STU_SCI_LITERACY.


## F-statistic: ##

# F-statistic: 11.83 on 1 and 94 DF,  p-value: 0.0008727

# The F-statistic tests the overall significance of the model.
# A low p-value (0.0008727) indicates that the model is
# statistically significant.

## Confidence Intervals ##

# Generate Confidence Intervals to gain more insights, such as 
# model precision, hypothesis testing, and prediction intervals
# and see plausible values for the intercept and slope.

# Use confint function to generate confidence intervals
confint(SLR_model, level = 0.95)

# Interpretation:

#                   2.5 %    97.5 %
#  (Intercept) 423.216286 484.41236
#  WEALTH        9.977911  37.24272

# For intercept: We are 95% confident that the true value of 
# the intercept score lies between approximately 
# 424.74 and 484.81. 

# For WEALTH: We are 95% confident that the true value of the 
# slope lies between approximately 9.96 and 36.84.

# Narrower intervals suggest more precise estimates, while 
# wider intervals indicate less precision.

# If the CI for a coefficient does not include zero, it suggests 
# that the corresponding predictor variable has a statistically 
# significant relationship with the response variable at 95%.

# If it includes zero, it suggests that the predictor variable
# does not have a statistically significant relationship with
# the response variable at 95%.

# CIs reflect the variability in the data and how much the 
# estimated coefficients might vary if different samples were 
# taken from the same population.



##### Step 7: Model Visualization #####
# Visualizing the model can help in understanding the
# relationship between the predictor and the response variable.


# Use ggplot2 for better visualization
library(ggplot2)

# Create a scatter plot with residuals and a regression line
ggplot(dat_cleaned, aes(x = WEALTH, y = STU_SCI_LITERACY)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Simple Linear Regression Model",
       x = "Wealth",
       y = "Science Literacy") +
  theme_minimal()

# What is the least-squares regression line?
# The least-squares regression line is the line that minimizes
# the sum of the squared differences between the observed
# values and the predicted values. It is the line that best
# fits the data in terms of minimizing the sum of squared
# residuals.

# The gray shadow around the regression line in your plot 
# represents the confidence interval for the regression line. 

# The shadow indicates the uncertainty around the estimated 
# regression line; a wider shadow suggests greater uncertainty 
# about the true position of the line. The confidence interval 
# is influenced by factors such as the variability of the data 
# and the sample size.


##### Step 8: Model Diagnostics #####
# Model diagnostics are used to assess the assumptions of the
# linear regression model and to identify any potential issues
# with the model.

# To check the assumptions of the linear regression model, we
# can use the following diagnostic plots:

par(mfrow = c(2, 2))  # Arrange the plots layout in a 2x2 grid
plot(SLR_model)

par(mfrow = c(1, 1))  # Ensure to reset to default single plot


#### 1) Residuals vs Fitted plot: ####

# This plot is used to check for linearity and homoscedasticity.
# The plot should show a random pattern with no clear
# relationship between the residuals and the fitted values.
# If you see a clear pattern or a curve, it suggests that the
# linearity assumption may be violated.


#### 2) Q-Q Residuals plot: ####

# This plot is used to check the normality assumption. The plot
# should show the residuals following a straight line, indicating
# that they are normally distributed. If the points deviate
# significantly from the straight line, it suggests that the
# normality assumption may be violated.


#### 3) Scale-Location plot: ####

# This plot is used to check the homoscedasticity assumption. The
# plot should show a random pattern with no clear relationship
# between the residuals and the fitted values. If you see a clear
# pattern or a curve, it suggests that the homoscedasticity
# assumption may be violated.

#### 4) Residuals vs Leverage plot: ####

# This plot is used to check for influential observations.
# Influential observations can have a large impact on the
# regression coefficients and can affect the validity of the model.
# The plot should show no observations with high leverage and high
# residuals. Observations that are high leverage and high residuals
# are potential outliers that may need further investigation.

# The dotted lines represent Cook's distance, which
# can be used to identify influential observations.

### Why are these diagnostic plots important? ###

# The diagnostic plots are important because they help to assess
# the assumptions of the linear regression model and identify
# any potential issues with the model. By examining these plots,
# we can determine if the model is appropriate for the data and
# if any adjustments need to be made to improve the model's
# performance.








##### Step 9: Predict the Y value #####

# Let's predict a student's science literacy score when:

# 1) The WEALTH is +2.0 away from the mean
predict(SLR_model, data.frame(WEALTH = 2.0))

# 2) The WEALTH is negative 4.0 away from the mean
predict(SLR_model, data.frame(WEALTH = -4.0))

# To reiterate: The model predicts that a student's science 
# literacy score will be 501 when the WEALTH is 2.0 away
# from the mean, and 359 when the WEALTH is negative 4.0
# away from the mean.

# Extract R-squared value from the model
summary(SLR_model)$r.squared

# To reiterate: The R-squared value of the model is 0.1117, 
# which means that approximately 11.17% of the variability 
# in Science Literacy can be explained by WEALTH.

# That means there are other factors that contribute to the 
# remininig 89% of the variability in Science Literacy.

# The model is not a perfect fit, but multiple linear 
# regression can be used to account for other factors that
# may influence Science Literacy scores.

##### Moving onto Multiple Linear Regression #####

