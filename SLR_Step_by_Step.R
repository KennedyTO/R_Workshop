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
# SIMPLE LINEAR REGRESSION ANALYSIS.


##### Objectives of the Analysis #####
#1 Understand the direction of the relationship
#2 Determine the strength of the relationship
#3 Test the significance of the relationship
#4 Make predictions based on the relationship


### Variables of Interest ###
# X = Wealth (WEALTH): Predictor
# Y = Student's science literacy scores (STU_SCI_LITERACY)
#     Outcome Variable


#### Step 1: Load the Data ####
# Ensure you have a folder dedicated to this project on your
# computer and have the dataset "modified_Data.csv" saved in
# that folder.


# Set the Working Directory to the folder where the dataset is
# saved. This is important to ensure that R can find the file.


# You can navigate to your folder by using the ... button in
# the Files tab in RStudio.


# Alternatively, you can use the setwd() function to set the
# working directory manually.


# Please change the following file path to your "Your/File/Path".
setwd("/Users/kensuzuki/Desktop/R_Workshop/R Workshop Day3")


# Load the data
# Ensure to specify your own file path.
dat <- read.csv("/Users/kensuzuki/Desktop/R_Workshop/R Workshop Day3/modified_Data.csv")


# Load the data from a pop-up window by using the file.choose()
# dat <- read.csv(file.choose()) 


#### Step 2: Explore the Data ####
## Check the first 5 rows to get a glimpse of the data.
head(dat)


# If you want to check 10 rows, you can add "10" after your
# dataset name in the head() and tail() functions.
head(dat, 10)
tail(dat, 10)


# To check the structure of the dataset, use the str().
str(dat)


# Now, let's get the summary statistics of the dataset. This
# is also used to get the glimpse of the data.


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


#### Task 1.1: Use Summary () #############################
# (Review of Day 1)

# Use the summary() function to obtain the summary statistics
# of the variable "STU_SCI_LITERACY" (Student's Science 
# Literacy Scores) our outcome variable.


# (Your code here)
summary(dat$STU_SCI_LITERACY)


# If you obtained the following summary output, you are on 
# the right track!

# Min.   1st Qu.  Median   Mean   3rd Qu. Max. 
# 239.9   353.6   394.6   408.0   458.5   600.0 

# NEXT #####################################################



#### My interpretation of the summary: Min & Max ####

# The lowest score is 239.9, and the highest score is 600.0,
# which is quite a wide range of scores. To me it indicates 
# that I have a potentially diverse group of students with
# varying levels of science literacy.


## Review from Day 1: Manual Calculation##
# Using some of the methods we learned on day 1, let's do
# some manual calculations! 


# To make a clear presentation of the calculation, we will
# assign the Min and Max values to objects and calculate the
# range of the scores.


# First, assign the following object names to the Min and Max 
# values obtained.
min_score <- 239.9
max_score <- 600.0


# Next, calculate the range of the literacy scores and assign 
# an object name "total_range" to the result.
total_range <- max_score - min_score


# Print the range of the scores.
print(total_range)


#### Task 1.2 ## (Review of Day 1): Your turn! #############

# We want to find out the central tendency of the student's
# science literacy scores and the proportion of the middle 
# 50% of the distribution relative to the "total_range".

# Let's calculate the 1st and 3rd Quartile range AKA the
# Inter-Quartile Range (IQR: middle 50%) of the student's 
# science literacy scores. 

# We obtained the following summary:
# Min.   1st Qu.  Median   Mean   3rd Qu. Max. 
# 239.9   353.6   394.6   408.0   458.5   600.0 
  
## Step 1:

# From the Assign names to the 1st and 3rd Quartile values as 
# Q1 and Q3.

# (Your code here)
Q1 <- 353.6
Q3 <- 458.5


## Step 2:

# Obtain IQR by subtracting Q1 from Q3 and store the 
# result as an object, "IQR_score".


# (Your code here):
IQR_score <- Q3 - Q1


## Step 3:

# Print the result.

# (Your code here):
print(IQR_score)


# Let's confirm if your calculation is correct. 
# R actually has a built-in function "IQR()" to calculate the 
# IQR value without manually processing like we just did... (Lol).
IQR(dat$STU_SCI_LITERACY)


# Lastly, please calculate the proportion of the IQR to the
# total range of the literacy scores and store the result as
# an object, "prop_IQR_total_range". 

# The formula is: (IQR / total_range) * 100


# (Your code here):
(IQR_score / total_range) * 100


# Proportion of the IQR to the total range of the literacy
# scores is about 30% of the total distribution range.
# This means that the middle 50% of the scores are spread
# over 30% of the total range of scores. 


# If this number is large, it indicates that the scores in 
# the data are spread out over a wide range.


# NEXT #####################################################


#### My Interpretation of the IQR: #########################

# If the IQR (Middle 50%) is large relative to the range of 
# scores, it indicates that the scores in the data are 
# spread out over a wide range. 


### My interpretation of the summary: Mean & Median ###
# - The mean score is 408.0
# - The median score is 394.6


# The median is less than the mean, which indicates that the
# distribution of the scores is positively skewed. This means
# that the distribution has more lower scores.


#### How to plot a simple Histogram ####
# If you are unsure about the distribution of the data, you
# may plot a histogram to visualize the distribution of the
# data.


####  Task 2.1: Generate a Histogram ######################
# Let's create a histogram of the student's science literacy 
# scores using the hist() function.


# The structure of the code is simple:
# hist(your_data$variable_name)


# (Your code here): 
hist(dat$STU_SCI_LITERACY) 


# NEXT #####################################################



#### Other options for Descriptive Statistics: ####
# Use describe() function from the "psych" package to get more 
# detailed statistics. (Review from Day 2)


#Install the package if you haven't done so.
# install.packages("psych") 


# Load the package
library(psych)


# Descriptive statistics of the entire dataset
psych::describe(dat) 


# psych:: is used to specify the package. I have other package
# that use the same "describe()" function for different outcome
# so I need to specify the package name.


## Some insights from the output: (Details in slides)

# Median and Mean: The median is less than the mean, which
# indicates that the distribution of the scores is positively
# skewed. This means that the distribution has more lower
# scores.


# If the median is more than the mean, it indicates a
# negatively skewed distribution. This means that the 
# distribution has more higher scores.


# Skewness tells you about the symmetry of the distribution.
# A skewness of 0 indicates symmetry. A positive skewness
# indicates a right-skewed distribution, while a negative
# skewness indicates a left-skewed distribution.


# Kurtosis tells you about the tails of the distribution.
# A kurtosis of 3 indicates a normal distribution. A kurtosis
# greater than 3 indicates heavier tails, while a kurtosis
# less than 3 indicates lighter tails.


# When you want to take a close look at just one variable:
# Use $ syntax to specify the variable name with describe()
# function.
psych::describe(dat$WEALTH) 


#### Use of describeBy() (Review from Day 2) ####

# Use "describeBy()" function to get descriptive statistics 
# by a specific group (factor variable). 


# In this case, I want to group by SEX variable in my dataset.
# Use "group = " to specify what variable you want to group by.
psych::describeBy(dat, group = dat$SEX)


# The order of appearance of the group is currently alphabetical.
# You can use the factor() and "level" argument to change 
# the order. 


# Let's say you want smaller group (Male) shown first and
# larger group (Female) shown second using the factor() and
# "level" argument.
dat$SEX <- factor(dat$SEX, levels = c("Male", "Female"))  


# Always check the structure of the data after changing the
# variable type using str() function.
str(dat)
psych::describeBy(dat, group = dat$SEX)


# Let's reverse the order to Female and Male by 
# changing back the variable type to Character.
dat$SEX <- as.character(dat$SEX) # Change back to character
str(dat) # Check the structure of the data again
psych::describeBy(dat, group = dat$SEX) # Check the output


#### Task 2.2 ## (Review of Day 2) ########################

# Drawing from the previous example, group the descriptive
# statistics by the variable "REPEAT".

# This variable shows if a student repeated a grade. 
# With 0 being "No" and 1 being "Yes."


# (Your code here)
psych::describeBy(dat, group = dat$REPEAT)

# if you see group 0 and group 1 in the output, you are
# on the right track!


## Task 2.3 ##
# Chage the order of the group to show "1" first and then
# "0" using the factor() and "level" argument.


# (Your code here)


# NEXT #####################################################




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


# Change the variable name to "LANGUAGE" using the 
# pipe operator and "rename()" function.
dat_cleaned <- dat %>% rename(LANGUAGE = ST022Q01TA)


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
str(dat)


# Notice some variables have "int" and "chr" as data types.
# We touched on this on Day 1 and Day 2:
# "num" = numeric 
# "int" = integer 
# "chr" = character  
# "fct" = factor 
# "dbl" = double
# "lgl" = logical
# "dttm" = date-time


# Change Integer values (PARENT_ED and REPEAT) to numeric values
# and save them as new variables (num_PARENT_ED and num_REPEAT)


#### Tips of data handling ####
# saving it as a new variable is a good practice to keep the
# original data intact. However, it can also increase the size
# of the file and computational demand.


# The structure of the mutate function is:
# mutate(new_variable_name = as.numeric(old_variable_name))


# Let's do it using the pipe operator
dat_cleaned <- dat_cleaned %>% 
  mutate(num_PARENT_ED = as.numeric(PARENT_ED))


# Check the outcome
str(dat_cleaned)


#### Task 3.1: Changing variable types #####################
# Following the example above, change the REPEAT variable to
# a numeric variable and save it under the name num_REPEAT.


# (Your code here)
dat_cleaned <- dat_cleaned %>% 
  mutate(num_REPEAT = as.numeric(REPEAT))

# Check the outcome: Use str() function
str(dat_cleaned)


#### Task 3.2 Review of Mutate () ##########################

# Change SEX variable and LANGUAGE variable together to 
# factor variables using pipe operators and the mutate() 
# function.

# The structure of the mutate function is:
# mutate(new_variable_name = as.factor(old_variable_name))
# Leave the variable names as their original names.


#(Your code here)
dat_cleaned <- dat_cleaned %>% 
  mutate(SEX = as.factor(SEX),
         LANGUAGE = as.factor(LANGUAGE))


# Check the outcome
str(dat_cleaned)

# NEXT #####################################################



#### 3) Addressing Missing Data ####

# Dealing with missing data is extensive and can easily take 
# up an entire workshop on its own. 


# There are several ways to deal with missing data:

# For the time being, we will focus on a simple deletion of
# missing values. This list-wise deletion is only appropriate 
# if the missing values are random. It is the "last resort" 
# and should only be used if you can't find other solutions.


# Let's look at summary statistics to see if there are any
# missing values in the dataset.
summary(dat_cleaned)


# Notice there is NA's in the list of parameters for some
# variables? This indicates that there are missing values.
# We don't know why the data is missing at this time.


# R has a built-in function to check for missing values.
# To find missing values, use the is.na() function
sum(is.na(dat))


# If there are missing values, you can remove rows with NA
# values using the na.omit() function. You can continue to
# assign results to the current dataset "dat_cleaned".
dat_cleaned <- na.omit(dat)


# Check for missing values in the cleaned data
sum(is.na(dat_cleaned))


# Look at the summary of the data
summary(dat_cleaned)



##### Step 4: Exploratory Data Analysis (EDA) #####
# EDA is an approach to analyzing data sets to summarize their
# main characteristics, often with visual methods. We see
# them in the literature, and they are often come straight
# from the visualization using R.


# Let's start by looking at the summary statistics of the
# variables of interest: WEALTH and STU_SCI_LITERACY.


### MANY WAYS TO WRITE CODE - DEMONSTRATION ###

# 1) WEALTH and STU_SCI_LITERACY individually.
psych::describe(dat_cleaned$WEALTH)
psych::describe(dat_cleaned$STU_SCI_LITERACY)


# 2) Combine them together with c() function [Traditional]. 
psych::describe(dat_cleaned[,c("WEALTH", "STU_SCI_LITERACY")])


# 3) Using pipe operators:
# Fist, you identify the dataset you reference. 
# Next use select() and the variables of interest. 
# Finally, use the describe() function to get the 
# summary statistics.


dat_cleaned %>% 
  select(WEALTH, STU_SCI_LITERACY) %>% 
  psych::describe() # describe() is a psych package function.



#### Desnity Plot, Scatter Plot, And Correlation ####

# I often use the GGally package to create a scatter plot matrix
# This package will create a scatter plot matrix with Density
# plot, Scatter plot, and Correlation.


# This function helps me to visualize the relationship between
# the variables and the distribution of the variables.


# Use ggplot2 and GGally package to create a scatter plot matrix
library(ggplot2)


# Install the GGally package if you haven't done so.
# install.packages("GGally") 
library(GGally)


# Create a scatter plot matrix with pipe operator
dat_cleaned %>%
  select(WEALTH, STU_SCI_LITERACY) %>%
  ggpairs()

# check the correlation between WEALTH and STU_SCI_LITERACY
str(dat_cleaned)

# What to look for in the Matrix:
# 1) The relationship between the variables 
# 2) The distribution of the variables
# 3) The correlation between the variables
# 4) Watch for multicollinearity 
# (if two or more IVs are highly correlated).


# Strength of correlation (just as a guideline):
# 0.1 - 0.3: Weak
# 0.3 - 0.5: Moderate
# 0.5 - 1.0: Strong



#### Task 4.1 Creating a Matrix for Descriptive Stats ######
# Let's have some fun with visualization. Drawing from the
# GGally example, please create a matrix with the following 
# variables: WEALTH, SEX, STU_SCI_LITERACY, and HOME_POS.
# Please note, you may need to change the size of the "Plots"
# window to see the entire matrix. 


# (Your code here)
dat_cleaned %>% 
  select(WEALTH, SEX, STU_SCI_LITERACY,HOUSE_POS) %>%
  ggpairs()


## Task 4.2 Interpreting ggpairs() ########################
# Briefly describe your interpretation of the correlation 
# between the HOUSE_POS (rate of possessions for 16 critical 
# household items) and WEALTH variables. Ensure to describe 
# the two charts, Correlation and Scatter plot.


# (Your interpretation for correlation)


# (Your interpretation for scatter plot)


# NEXT #####################################################


#### Step 5: SIMPLE LINEAR REGRESSION!! (SLR) ####

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
# Structure of the lm() is lm(Y ~ X, data = your_data)


SLR_model <- lm(STU_SCI_LITERACY ~ WEALTH, data = dat_cleaned)


# Use summary() to generate a summary of the model.
summary(SLR_model)


# Let's make another SLR model with a different variable 
# before we interpret the summary output.

#### Task 5 Build an SLR Model #############################

# Let's create a Simple Linear Model for the following
# theory: Repeating a grade will influence a student's
# science literacy score in a positive way. 

# The parameter that gauges the grade repetition is "REPEAT" 
# and the dependent variable is STU_SCI_LITERACY. 

# Please ensure to name your model "SLR_model_02". 
# Finally, provide a summary of the model.


# (Your code here)
SLR_model_02 <- lm(STU_SCI_LITERACY ~ REPEAT, data = dat_cleaned)

# (Your summary here)
summary(SLR_model_02)


# NEXT #####################################################


#### Step 6.1: Interpretation of the Summary() output: ####

# Here is the interpretation of the summary output for
# the relationship between wealth and student's science
# literacy scores.


# From the top of the summary, the RESIDUALS show:

# Call:
# lm(formula = STU_SCI_LITERACY ~ WEALTH, data = dat_cleaned)

#  Min       1Q       Median     3Q      Max 
#-165.633  -45.435   -1.262   42.614  182.153 


#### What is Residuals? ####
# Residuals are the difference between the observed value
# and the predicted value. The residuals are the errors
# of the model. 


#### What to look for in the Residuals? ####
# The residuals should be normally distributed around zero.
# If the residuals are not normally distributed, it indicates
# that the model may not be appropriate for the data.


#### My interpretation of Residuals Report ####
# Theoretically, if the residual is ZERO (never happens) that 
# means your model has no error and predicts the outcome 100%
# accurately every time. 


# Therefore, the narrower the distribution of the residuals
# around zero, the better the model is at predicting the
# outcome variable.


# If you want to visually inspect the residuals, you can
# save the residual values as an object and create a histogram
# of the residuals.


#### Create a Histogram of the Residuals #### 
# First we extract the residuals from the model by using the
# resid() function and store them as an object, residuals_SLR.
residuals_SLR <- resid(SLR_model)


# and then plot the residuals using a histogram.
hist(residuals_SLR)


# We have our model diagnostics later on to check the
# assumptions of the linear regression model.This is 
# just a quick check to see if the residuals are
# normally distributed.


#### Task 6.1: Interpreting Residuals #####################

# Following is the output of the residuals from a simple linear
# regression between the Literacy Score and "REPEAT" variable.

# Provide a brief interpretation of the residuals below.

# The model:
#lm(formula = STU_SCI_LITERACY ~ REPEAT, data = dat_cleaned)

#Residuals Summary# 
#    Min       1Q       Median     3Q      Max 
#  -153.754  -32.162   -1.978   31.903  138.576 


# (Your interpretation here)


# If you have time, you can also plot the residuals to see
# if they are normally distributed using reside(). Ensure to
# change the object name to residuals_SLR_02 so you won't
# override the previous object.


# (Your code here)


# NEXT #####################################################


#### How to interpret Coefficients: ####
# The coefficients table shows the estimated coefficients 
# for the intercept β0 and the slope β1. 


# The coefficient of intercept (453.814) is the expected 
# value of a student's Science Literacy score when WEALTH is 0. 


# Std. Error 15.411 and t-value 24.448 are there to get the 
# used to get the p-value for the null hypothesis statistical
# testing for the intercept.


# The question is can anyone have ZERO wealth???


# The coefficient of WEALTH (23.610) indicates that for each 
# unit increase in WEALTH, the science literacy score is 
# "EXPECTED" to increase by 23.610 units.


# Both coefficients are statistically significant when the 
# p-value is less than 0.05, indicating a strong relationship 
# between WEALTH and Student Literacy scores.


#### Task 6.2 Interpreting Coefficients ####################

# Provide an interpretation of the coefficients for the
# REPEAT variable in the SLR model.

# Coefficients:
#               Estimate Std. Error   t value   Pr(>|t|)    
# (Intercept)   461.46        10.86   42.506   < 2e-16 ***
#  REPEAT       -83.25        13.40   -6.212  1.42e-08 ***
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1


# (Your interpretation here)


# NEXT #####################################################


#### How to interpret Residual Standard Error: ####
# RSE: 69.81 on 94 degrees of freedom.
# This value gives an idea of the average size of the 
# residuals, or how far the data points are from the 
# regression line on average.


#### How to interpret R-squared: ####
# Multiple R-squared:  0.1117 (For a single variable)
# Adjusted R-squared:  0.1023 (for Multiple variables)

# This parameter is often used to gauge the prediction accuracy.
# The closer the value is to 1 (100%), the better the model.

# The Multiple R-squared (0.1117) indicates that approximately 
# 11.17% of the variability in STU_SCI_LITERACY can be explained 
# by WEALTH. In other words, WEALTH accounts for 11.17% of the
# variability in STU_SCI_LITERACY.
  

#### How to interpret F-statistic: ####
# F-statistic: 11.83 on 1 and 94 DF,  p-value: 0.0008727
# The F-statistic tests the overall significance of the model.
# A low p-value (0.0008727) indicates that this SLR model is
# statistically significant.


# make a simple linear regression of the REPEAT variable
# and provide an interpretation of the summary output.


#### Task 6.2 ###############################################

# Please provide your interpretation of the summary output:

# Residual standard error: 62.36 on 94 degrees of freedom
# Multiple R-squared:  0.291,	Adjusted R-squared:  0.2835 
# F-statistic: 38.59 on 1 and 94 DF,  p-value: 1.416e-08


# (Your interpretation here)
# The residual standard error is 62.36, which means that the
# average size of the residuals is 62.36 points. 

# The R-squared value is 0.291, which means that approximately
# 29.1% of the variability in Science Literacy can be explained
# by the REPEAT variable.

# The F-statistic is 38.59, with a p-value of 1.416e-08, which
# indicates that the model is statistically significant when
# p-value is less than 0.05.

# NEXT #####################################################



#### Step 6.2: Calculate Confidence Intervals ####
# We use confidence intervals to gain more insights, such as
# model precision, hypothesis testing, and prediction 
# intervals. 

# Use confint() function to generate confidence intervals
confint(SLR_model, level = 0.95)

# This way of coding allows you to change the confidence level.
# 0.95 for p =< 0.05, 0.99 for p =< 0.01, etc.

# For intercept: We are 95% confident that the true value of 
# the intercept score lies between approximately 
# 424.74 and 484.81. 


# For WEALTH: We are 95% confident that the true value of the 
# slope lies between approximately 9.96 and 36.84.


# Narrower intervals suggest more precise estimates, while 
# wider intervals indicate less precision.



##### Step 7: Model Visualization #####
# Visualizing the model can help in understanding the
# relationship between the predictor and the response variable.


# ggplot2 is a popular data visualization package in R.
library(ggplot2)

# In ggplot2, the code structure has a base part and additional
# layers that can be added to customize the plot.

ggplot(dat_cleaned, aes(x = WEALTH, y = STU_SCI_LITERACY)) +
  geom_point() + 
  geom_smooth(method = "lm", se = TRUE) +
  labs(title = "Simple Linear Regression Model",
       x = "Wealth",
       y = "Science Literacy") +
  theme_minimal()

# Where:
# ggplot(dat_cleaned, aes(x = WEALTH, y = STU_SCI_LITERACY))
# is base part to specify the data and aesthetics mapping. Plus,

# geom_point() adds points to the plot. Plus,

# geom_smooth() regression line with "lm" method
# and "se = TRUE" adds the confidence interval to the line, 
# plus

# The labs() function is used to add titles to the plot.
# And finally, the theme_minimal() function calls for a 
# minimal theme for the plot.

# Note - all these components are connected with "+"s.


##### Step 8: Model Diagnostics #####
# Model diagnostics are used to assess the assumptions of the
# linear regression model and to identify any potential issues
# with the model.

### Why are the diagnostic plots important? ###
# Model diagnostics can give you ways to:
# 1) check assumptions of the linear regression.
# 2) check for outliers and influential points.
# 3) check for how well the model fits the data.

#### Conducting Model Diagnostics ####
# To check the assumptions of the linear regression model, we
# use par() function to arrange the plots in a grid layout.
# (mflow = c(2, 2)) arranges the plots in a 2x2 grid.


par(mfrow = c(2, 2))  # Arrange the plots layout in a 2x2 grid
plot(SLR_model)

# Ensure to reverse the layout back to the default using
# this code.
par(mfrow = c(1, 1))  


#### Task 8.1: Conducting Model Diagnostics ################

# Please use the SLR model "SLR_model" and conduct
# model diagnostics using the plot() function.

# (Your code here)
par(mfrow = c(2, 2))  # Arrange the plots layout in a 2x2 grid
plot(SLR_model)

# Ensure to reverse the layout back to the default using
# this code.
par(mfrow = c(1, 1))


# Provide your brief interpretation of the four plots


# (Your interpretation here)


# You may find this website helpful when interpreting the
# diagnostic plots:


#### Diagnositcs - Reference Material ######################

# Kim, B. (2015, September 21). 
# Understanding Diagnostic Plots for Linear Regression 
# Analysis | UVA Library [StatLab Articles]. 

# Research Data Services & Social, Natural, and Engineering 
# Sciences. 

# https://library.virginia.edu/data/articles/diagnostic-plots

# NEXT #####################################################


##### Step 9: Predict the Y value #####
# Let's predict a student's science literacy score when:

# 1) The WEALTH is +2.0 away from the mean
prediction01 <- predict(SLR_model, data.frame(WEALTH = 2.0))
print(prediction01)


# Calculate with Residual Standard Error:
lower_bound01 <- prediction01 - 69.81 # RSE from the Summary()
upper_bound01 <- prediction01 + 69.81
print(c("Lower Bound" = lower_bound01, "Upper Bound" = upper_bound01))


# 2) The WEALTH is negative 4.0 away from the mean
prediction02 <- predict(SLR_model, data.frame(WEALTH = -4.0))
print(prediction02)


# Calculate with Residual Standard Error:
lower_bound02 <- prediction02 - 69.81 # RSE from the Summary()
upper_bound02 <- prediction02 + 69.81
print(c("Lower Bound" = lower_bound02, "Upper Bound" = upper_bound02))


# Review: Extract R-squared value from the model
summary(SLR_model)$r.squared


#### Task 9.1: Predict the Y value ########################

# Predict the student's science literacy score when the
# WEALTH is +3.0 away from the mean.


# (Your code here)


# Predict the student's science literacy score when the
# WEALTH is - 2.0 away from the mean.


# (Your code here)


# NEXT #####################################################


# To reiterate: The R-squared value of the model is 0.1117, 
# which means that approximately 11.17% of the variability 
# in Science Literacy can be explained by WEALTH.

# That means there are other factors that contribute to the 
# remaining 89% of the variability in Science Literacy.

# The model is not a perfect fit, but multiple linear 
# regression can be used to account for other factors that
# may influence Science Literacy scores.

