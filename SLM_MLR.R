### Simple Linear Regression ###

### Initial Operations ###

# Load the data
dat <- read.csv("~/Desktop/R_Workshop/R Workshop Day3/Data.csv")

# View the structure of the data before conversion
str(dat)

### We now want to change some of the variables to numeric and factors

# Convert the SEX variable to a factor with labels "Male" and "Female"
dat$SEX <- factor(dat$SEX, levels = c(0, 1), labels = c("Male", "Female"))

# Convert the LANGUAGE variable to a factor with labels "Primary" and "Secondary"
dat$LANGUAGE <- factor(dat$LANGUAGE, levels = c(0, 1), labels = c("Primary", "Secondary"))

# View the structure of the data after conversion
str(dat)

# Save the modified dataset to a new CSV file
write.csv(dat, "~/Desktop/R_Workshop/R Workshop Day3/modified_Data.csv", row.names = FALSE)

# Load the modified dataset from the CSV file
dat <- read.csv("~/Desktop/R_Workshop/R Workshop Day3/modified_Data.csv")

str(dat)

# Display the data frame
print(dat)


# Taking a look at the Data structure
## Evaluate the structure of the dataset and ensure that the data types are correct
head(dat)
str(dat)

###############  Data Clearning Assignment  #################

#1 Use mutate() function to change variable type from integer to numeric

#2 Check if there are missing values in the dataset

#############################################################

# Load the dplyr package
library(dplyr)


# Confirm the change
str(dat)


#2 Change multiple integer variables to numeric variables using pipe operator.
## For better arithmetic operations, the variables must be changed to 'numeric'.
dat <- dat %>%
  mutate(PARENT_ED = as.numeric(PARENT_ED),
         REPEAT = as.numeric(REPEAT),
         SEX = as.numeric(SEX),
         LANGUAGE = as.numeric(LANGUAGE))
         

# Confirm the changes
str(dat)


#3 Change SEX variable from 1 and 2 to 0 and 1 using pipe operator

## Method 1 ##
dat <- dat %>%
  mutate(SEX = recode(SEX, '1' = 0, '2' = 1))


## Method 2 ##
### Another way to code with ifelse function
dat <- dat %>%
  mutate(SEX = ifelse(SEX == 1, 0, 1))

# This code interprets as follows: 
# 1. If the value is 1, change it to 0, 
# 2. if it is NOT 1 (e.g., 2), change it to 1

#4 Change LANGUAGE variable from 1-English 2-Other to 0 and 1
dat <- dat %>%
  mutate(LANGUAGE = ifelse(LANGUAGE == 1, 0, 1))


## Descriptive Statistics ##
summary(dat)


  
