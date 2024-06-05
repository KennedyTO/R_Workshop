##### Simple Linear Regression #####
## STEP-BY-STEP GUIDE ##

# This script is designed to provide a step-by-step guide to
# participants who are new to R and are interested in learning
# how to conduct a simple linear regression analysis.

# Simple Linear Regression (SLR) is a statistical method that
# allows us to summarize and examine the relationship between
# two continuous (quantitative) variables. It is a method that
# can be used to predict the value of one variable based on the
# value of another variable.

# Linear regression models are theory-driven, meaning that they
# are based on the assumption that there is a linear relationship
# between the independent variable (predictor) and the dependent
# variable (outcome).

### MY THEORY ###
# I believe that students from wealthier families tend to have 
# higher science literacy scores. 

# In other words, Wealth should predict Student's science 
# literacy score.

### Variables ###
# X = Wealth (Standardized measure of wealth)
# Y = Student's science literacy scores


##### Objectives of the Analysis #####
#1 Understand the direction of the relationship
#2 Determine the strength of the relationship
#3 Test the significance of the relationship
#4 Make predictions based on the relationship

##### Initial Preparation #####
##### Step 1: Load the Data #####

# Set the Working Directory
# Ensure to change to your "local file location."
setwd("~/Desktop/R_Workshop/R Workshop Day3")


# Load the data - Mac Users:
# Ensure to specify your own file path.
dat <- read.csv("~/Desktop/R_Workshop/R Workshop Day3/modified_Data.csv")


# If you are a Windows user:
# dat <- read.csv("C:/Users/YourUsername/Desktop/FileName.csv")


# Load the data from a pop-up window
# dat <- read.csv(file.choose())


####### Step 2: Explore the Data ######

## Check the first few rows ##
head(dat)


## Get the structure of the data ##
str(dat)

# Notice some variables have "int" and "chr" as data types.
# The rest is "num".

# num = numeric variable
# int = integer variable
# chr = character variable 
# fct = factor variable

# For SLR, we need to make sure that the variables are 
# "NUMERIC", "INTEGER", or "FACTOR".

# Ensure that your outcome variable is "Continuous" variable
# and it is set to "NUMERIC".

# What is NUMERIC Variable?
# Numeric variables are continuous variables that can take
# any value within a range. They are used for quantitative
# data.

# What is INTEGER Variable?
# Integer variables are used to represent whole numbers.

# What is CHARACTER Variable?
# Character variables are used to represent text data.
# Such as SEX and ST022Q01TA (Language type) in our dataset. 

# What is FACTOR Variable? 
# Factors are used to represent categorical data.



## Descriptive statistics ##
# The summary() function provides a quick overview of the data.
summary(dat)


# Summary() will display:
# Min-max
# 1st and 3rd quartile
# Median
# Mean
# Look for 'Number of missing values' shown as "NA"


## The other option: ##
# Use describe() function from the psych package for more 
# detailed statistics
library(psych)


describe(dat) # This will provide more detailed statistics

# Use descriBy(data, group = data$variable) to get descriptive
# statistics by a specific group.

# Descriptive statistics by SEX. 
describeBy(dat, group = dat$SEX) 

# When you have a specific variable(s) in mind:
summary(dat$WEALTH) # Summary of Wealth

# You can also use the hist() function to create a histogram
hist(dat$WEALTH) # Histogram of Wealth)


# NA values imply that I have missing data in my dataset.
# Data cleaning is necessary to properly analyze the data.



########### Step 3: Clean the Data ############
# 1) Address missing values - This is very important
# 2) Change variable name "ST022Q01TA" to "LANGUAGE."
# 3) Change the integer variables to numeric variables.
# 4) Change Character variables to Factor variables.


##### 1) Addressing Missing Data #####
# Missing values can be problematic in data analysis.
# Mishandling of missing data can lead to biased results or 
# incorrect conclusions.

# There are several ways to handle missing values, such as 
# deletion or imputation. For instance, if the missing values 
# are random, deletion might be appropriate. 

# However, deleting missing values leads to a loss of 
# your valuable data that you collected.
# (Collecting data is not cheap, is it?)

# There are ways to rectify this issue, such as "imputation."

# If the missing values are systematic, such that they are 
# related to other variables, imputation, which fills in the 
# missing values with estimated values, may work better.

# Dealing with missing data is extensive and can easily take 
# up an entire workshop on its own. For now, please know that
# there are ways to handle missing data without losing your 
# valuable data points. 

# In this workshop, we will focus on a simple deletion.


# Check for missing values
sum(is.na(dat))


# If there are missing values, you can remove rows with NA
dat_cleaned <- na.omit(dat)


# Delete missing values using pipe operator
library(dplyr) # if you haven't loaded the package
dat_cleaned <- dat %>% na.omit()


# Check for missing values in the cleaned data
sum(is.na(dat_cleaned))


## Transform data (Changing values) ##

# Look at the structure of the data
str(dat_cleaned)


##### 2) Change the variable name using the Pipe operator #####

# Change the variable name using "rename" function
dat_cleaned <- dat_cleaned %>% 
  rename(LANGUAGE = ST022Q01TA)

# Check the outcome
str(dat_cleaned)



##### 3) Change the integer variables to numeric variables. #####

# Change Integer values (PARENT_ED and REPEAT) to numeric values
# and save them as new variables (num_PARENT_ED and num_REPEAT)
dat_cleaned$num_PARENT_ED <- as.numeric(dat_cleaned$PARENT_ED)
dat_cleaned$num_REPEAT <- as.numeric(dat_cleaned$REPEAT)

# Check the outcome
str(dat_cleaned)


##### 4) Change Character variables to Factor variables. #####

# Change SEX variable and LANGUAGE variable to a factor with 
# pipe operator
dat_cleaned <- dat_cleaned %>% 
  mutate(SEX = as.factor(SEX),
         LANGUAGE = as.factor(LANGUAGE))


# Check the outcome
str(dat_cleaned)


##### Tips for handling data #####

# Saving variables in different names or overwriting the 
# original variables? It is a good practice to save the 
# transformed variables in different names to avoid 
# overwriting the original variables (works as a backup and 
# Improved transparency of the data processing).

# If your data is large, creating another variable increases 
# the memory usage. In this case, it is your discretion to 
# overwrite the original variable to save memory.

##### Data Analyses #####
##### Step 4: Exploratory Data Analysis (EDA) #####
# EDA is an approach to analyze datasets to summarize their 
# main characteristics, often with visual methods.


# Calculate Summary Statistics
summary(dat_cleaned$WEALTH)
summary(dat_cleaned$STU_SCI_LITERACY)


# Scatter plot (Y = WEALTH, Y = STU_SCI_LITERACY)
plot(dat_cleaned$WEALTH, dat_cleaned$STU_SCI_LITERACY)

# Look for:
# Direction of the relationship
# Strength of the relationship
# Outliers


# Check for correlation between WEALTH and STU_SCI_LITERACY
cor(dat_cleaned$WEALTH, dat_cleaned$STU_SCI_LITERACY)

# Look for:
# Direction of the relationship
# Strength of the relationship



##### Step 5: Building a Simple Linear Regression (SLR) #####

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

##### Step 6 Interpretation of the Summary() output: #####

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
confint(SLR_model)

# Interpretation:

#                   2.5 %    97.5 %
#  (Intercept) 423.216286 484.41236
#  WEALTH        9.977911  37.24272

# We are 95% confident that the true value of the intercept 
# lies between approximately 424.74 and 484.81.

# We are 95% confident that the true value of the slope lies
# between approximately 9.96 and 36.84.

# Narrower intervals suggest more precise estimates, while 
# wider intervals indicate less precision.

# If the CI for a coefficient does not include zero, it suggests 
# that the corresponding predictor variable has a statistically 
# significant relationship with the response variable at 95%.

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
  geom_smooth(method = "lm", se = TRUE) +
  labs(title = "Simple Linear Regression Model",
       x = "WEALTH",
       y = "STU_SCI_LITERACY") +
  theme_minimal()

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


### Residuals vs Fitted plot: ###

# Linearity:
# The residuals vs. fitted plot is used to check the linearity
# assumption. The plot should show a random pattern with no
# clear relationship between the residuals and the fitted values.

# Homoscedasticity:
# The residuals vs. fitted plot is also used to check the
# homoscedasticity assumption. The plot should show a constant
# spread of residuals across the range of fitted values.

### Q-Q Residuals plot: ###
# Normality:
# The Q-Q plot of residuals is used to check the normality
# assumption. The plot should show the residuals following a
# straight line, indicating that they are normally distributed.

### Scale-Location plot: ###
# Homoscedasticity:
# The scale-location plot is used to check the homoscedasticity
# assumption. The plot should show a random pattern with no
# clear relationship between the residuals and the fitted values.

### Residuals vs Leverage plot: ###
# Influence:
# The residuals vs. leverage plot is used to check for influential
# observations. Influential observations can have a large impact
# on the regression coefficients and can affect the validity of
# the model. The plot should show no observations with high
# leverage and high residuals.



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

