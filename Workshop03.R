### Simple Linear Regression ###

### MY THEORY ###

# I believe that students from wealthier families tend to have 
# higher science literacy scores. In other words, Wealth should 
# predict Student's science literacy scores.


### Variables ###
# X = Wealth (Standardized measure of wealth)
# Y = Student's science literacy scores


### I this model, I want to: ###
#1 Understand the direction of the relationship
#2 Determine the strength of the relationship
#3 Test the significance of the relationship

# ---------------------------------------------------

###### Step 1 - Load the data ######

# Set the Working Directory
setwd("~/Desktop/R_Workshop/R Workshop Day3")
# This line of code changes based on your local file location.


# Load the data
dat <- read.csv("~/Desktop/R_Workshop/R Workshop Day3/modified_Data.csv")


# Load the data from a pop-up window
# dat <- read.csv(file.choose())


####### Step 2 - Explore the data ######

# Check the first few rows
head(dat)


# Get the structure of the data
str(dat)

# Check the structure of each variable
# num = numeric variable
# int = integer variable
# chr = character variable
# fct = factor variable
# For SLR, we need to make sure that the variables are "NUMERIC".


## Descriptive statistics ##
# The summary() function provides a quick overview of the data.
summary(dat)

# Summary() will display:
# Min-max
# 1st and 3rd quartile
# Median
# Mean
# 'Number of missing values' as NA


## The other option: ##
# Use describe() function from the psych package for more 
# detailed statistics
library(psych)

describe(dat) # This will provide more detailed statistics
describeBy(dat, group = dat$SEX) # Descriptive statistics by group


####### Step 3 - Data Cleaning ########

##### Tips: Handling Missing Data #####

# Missing values can be problematic in data analysis.
# Mishandling of missing data can lead to biased results or 
# incorrect conclusions.

# There are several ways to handle missing values, such as 
# deletion or imputation. For instance, if the missing values 
# are random, deletion might be appropriate. If the missing 
# values are systematic, such that they are related to other 
# variables, imputation, which fills in the missing values 
# with estimated values based on the observed data, may work 
# better.

# Dealing with missing data is extensive and can easily take 
# up an entire workshop on its own. For now, we will focus 
# on a simple deletion of missing values.

# ------------------------------------------------------------------
# Check for missing values
sum(is.na(dat))


# If there are missing values, you can remove rows with NA
dat_cleaned <- na.omit(dat)


# Check for missing values in the cleaned data
sum(is.na(dat_cleaned))


## Transform data (Changing values) ##

# Look at the structure of the data
str(dat_cleaned)


# Change Integer values (PARENT_ED and REPEAT) to numeric values
dat_cleaned$num_PARENT_ED <- as.numeric(dat_cleaned$PARENT_ED)
dat_cleaned$num_REPEAT <- as.numeric(dat_cleaned$REPEAT)

# Check the outcome
str(dat_cleaned)

# OR, you can use the dplyr package to change the variable 
# types at once.

# Load the dplyr package
library(dplyr)

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
# -----------------------------------------------------------


###### Step 4 - Exploratory Data Analysis (EDA) ######
# EDA is an approach to analyze datasets to summarize their 
# main characteristics, often with visual methods.


# Scatter plot (Y = WEALTH, Y = STU_SCI_LITERACY)
plot(dat_cleaned$WEALTH, dat_cleaned$STU_SCI_LITERACY)


# Calculate Summary Statistics
summary(dat_cleaned$WEALTH)
summary(dat_cleaned$STU_SCI_LITERACY)


# Check for correlation between WEALTH and STU_SCI_LITERACY
cor(dat_cleaned$WEALTH, dat_cleaned$STU_SCI_LITERACY)


##### Building a Simple Linear Regression (SLR) in R: #####

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


#### Fit a simple linear regression model ####
# Use the lm() function to fit a simple linear regression model

# Fit a simple linear regression model
SLR_model <- lm(STU_SCI_LITERACY ~ WEALTH, data = dat_cleaned)

# Check the model
summary(model_SLM)

# Interpretation of the Summary() output:

# 1. The coefficients table shows the estimated coefficients 
# for the intercept and the slope.

