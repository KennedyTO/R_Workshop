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
# Ensure to change to "the local file location."


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


# When you have a specific variable(s) in mind:
summary(dat$WEALTH) # Summary of Wealth

hist(dat$WEALTH) # Histogram of Wealth)
# You can check the skewness (Long tails on the right or left)

# Because of the NA values, now I know I need to clean the data.

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
summary(SLR_model)

##### Interpretation of the Summary() output: #####

# Residuals:##
#  Min       1Q   Median       3Q      Max 
# -167.022  -45.181    1.536   43.769  180.873 

## Redisuals - Histogram ##
residuals_SLR <- resid(SLR_model)
hist(residuals_SLR)


## Coefficients: ##

# The coefficients table shows the estimated coefficients 
# for the intercept and the slope. In other words, it shows
# the estimated values of β0 and β1.

# The intercept (454.77) is the expected value of STU_SCI_LITERACY 
# when WEALTH is 0.

# The slope (23.40) indicates that for each unit increase in WEALTH, 
# STU_SCI_LITERACY is expected to increase by 23.40 units.

# Both coefficients are statistically significant (p < 0.05), 
# indicating a strong relationship between the predictor (WEALTH) 
# and the response variable (STU_SCI_LITERACY).


## Residual Standard Error: ##

#RSE: 69.54 on 95 degrees of freedom.

# The RSE measures the average amount that the response 
# variable deviates from the true regression line. In other words,
# it is the standard deviation of the residuals.
# A lower RSE indicates a better fit.


## R-squared: ##

# Multiple R-squared:  0.1117 (For a single variable)
# Adjusted R-squared:  0.1024 (for Multiple variables)

# The Multiple R-squared (0.1117) indicates that approximately 
# 11.17% of the variability in STU_SCI_LITERACY can be explained 
# by WEALTH. In other words, WEALTH accounts for 11.17% of the
# variability in STU_SCI_LITERACY.


## F-statistic: ##

# F-statistic: 11.95 on 1 and 95 DF,  p-value: 0.0008195

# The F-statistic tests the overall significance of the model.
# A low p-value (0.0008195) indicates that the model is
# statistically significant.


## Confidence Intervals: ##
confint(SLR_model)

# Interpretation:

#                 2.5 %    97.5 %
# (Intercept) 424.735929 484.81459
# WEALTH        9.961395  36.84033

# We are 95% confident that the true value of the intercept 
# lies between approximately 424.74 and 484.81.

# We are 95% confident that the true value of the slope lies
# between approximately 9.96 and 36.84.


##### Step 5 - Model Visualization #####
# Visualizing the model can help in understanding the
# relationship between the predictor and the response variable.


# Use ggplot2 for better visualization
library(ggplot2)

# Create a scatter plot
ggplot(dat_cleaned, aes(x = WEALTH, y = STU_SCI_LITERACY)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Simple Linear Regression Model",
       x = "WEALTH",
       y = "Literacy Score")


##### Step5 Model Diagnostics #####
# Model diagnostics are used to assess the assumptions of the
# linear regression model and to identify any potential issues
# with the model.

# To check the assumptions of the linear regression model, we
# can use the following diagnostic plots:
Library(car)
par(mfrow = c(2, 2))  # Arrange the plots layout in a 2x2 grid
plot(SLR_model)
par(mfrow = c(1, 1))  # Ensure to reset to default single plot

# 1) Linearity: The relationship between the predictor and the
# response variable should be linear.

# Residuals vs. Fitted plot

# 2) Homoscedasticity: The residuals should have constant variance.

# Residuals vs. Fitted plot

# 3) Normality: The residuals should be normally distributed.

# Normal Q-Q plot

# 4) Outliers: Identify any outliers that may affect the model.

# Residuals vs. Leverage plot



# 5) Independence: The residuals should be independent of each
# other.

plot(residuals_SLR)
# Checking for independence:
# Assuming your cleaned data frame is called 'dat_cleaned'
# Create an order of observations variable if it doesn't exist
dat_cleaned$obs_order <- 1:nrow(dat_cleaned)

# Plot residuals vs. order
plot(dat_cleaned$obs_order, residuals_SLR, 
     main = "Residuals vs Order of Observations", 
     xlab = "Order of Observations", 
     ylab = "Residuals")
abline(h = 0, col = "red")




##### Predict the Y value #####

# Let's predict a student's science literacy score when:

# 1) The WEALTH is 2.0 away from the mean
predict(SLR_model, data.frame(WEALTH = 2.0))

# 2) The WEALTH is negative 4.0 away from the mean
predict(SLR_model, data.frame(WEALTH = -4.0))
