##### Multiple Linear Regression #####

#### Loading the data ####

# Set the Working Directory
# Ensure to change to your "local file location."
setwd("~/Desktop/R_Workshop/R Workshop Day3")

# Load the data
dat <- read.csv("~/Desktop/R_Workshop/R Workshop Day3/modified_Data.csv")


#### Data Cleaning ####
# Check for missing values
sum(is.na(dat))


# If there are missing values, you can remove rows with NA
dat_cleaned <- na.omit(dat)


# Check for missing values in the cleaned data
sum(is.na(dat_cleaned))


## Transform data (Changing values) ##

# Look at the structure of the data
str(dat_cleaned)


#### Change the variable name using the Pipe operator ####

# Change the variable name using "rename" function
library(dplyr)
dat_cleaned <- dat_cleaned %>% 
  rename(LANGUAGE = ST022Q01TA)


#### Change the integer variables to numeric variables. ####

# Change Integer values (PARENT_ED and REPEAT) to numeric values
# and save them as new variables (num_PARENT_ED and num_REPEAT)
dat_cleaned$num_PARENT_ED <- as.numeric(dat_cleaned$PARENT_ED)
dat_cleaned$num_REPEAT <- as.numeric(dat_cleaned$REPEAT)



##### Change Character variables to Factor variables. ####

# Change SEX variable and LANGUAGE variable to a factor with 
# pipe operator
dat_cleaned <- dat_cleaned %>% 
  mutate(SEX = as.factor(SEX),
         LANGUAGE = as.factor(LANGUAGE))


# Check the outcome
str(dat_cleaned)


##### Building the Multiple Linear Regression Model ####

#### My Theory ####
# There is a significant relationship between House Possessions 
# (HOUSE_POS), Environmental Awareness (ENV_AWARENESS), 
# and Science Knowledge (SCI_KNOWLEDGE) with Science Literacy 
# (STU_SCI_LITERACY).

# Science Literacy = B0 + B1(HOUSE_POS) + B2(ENV_AWARENESS) + 
# B3(STU_SCI_LITERACY)


#### Building the Multiple Linear Regression Model ####

# Build the Multiple Linear Regression Model and name it MLR

# The structure of the lm function is as follows:
# lm(Y ~ X1 + X2 + X3...Xi, data = dataset)

set.seed(123)
MLR <- lm(STU_SCI_LITERACY ~ 
            HOUSE_POS + 
            ENV_AWARENESS + 
            SCI_KNOWLEDGE, data = dat_cleaned)

# Display the summary of the MLR model
summary(MLR)

# Confidence Interval
confint(MLR)

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
