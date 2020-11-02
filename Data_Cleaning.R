#Process of Data Cleaning
getwd()

#Read CSV of the files
Transactions= read.csv("Transactions.csv")
Demographics= read.csv("CustomerDemographic.csv")
Address= read.csv("CustomerAddress.csv")
View(Transactions)
View(Demographics)

#Find out the unique number of records.
nrow(Transactions)
length(unique(Transactions$customer_id))
nrow(Demographics)
length(unique(Demographics$customer_id))
nrow(Address)
length(unique(Address$customer_id))

#Make a Table

#Need to Check-

#Correct Values- Accuracy
#1.Checking the number of rows and columns against expectations.
#2.Checking for duplicates at id level.
#3.Check for blank columns, large % of blank data, high % of same data.
#4.Look at distribution across various segments.
#5.Check outliers on all key variables
#6.Check if values of a few test cases are in sync.
#7.Pick up a few rows and check out their values in underlying systems.

#For comparing customer IDs with the Master sheet of Customer Demographics.
library(dplyr)
TransactionsuniqueID= Transactions %>% select(customer_id) %>% distinct()
table(TransactionsuniqueID < 3999)
TransactionsuniqueID[TransactionsuniqueID > 3999]
#An extra ID 5034 was found. 
#Comparing for Address sheet.
AddressuniqueID= Address %>% select(customer_id) %>% distinct()
table(AddressuniqueID < 3999)
Address$customer_id[Address$customer_id > 4000]
tail(AddressuniqueID)
tail(Demographics$customer_id)
#Three IDs 4001, 4002, and 4003 were found. 
#5034, 4001, 4002, and 4003 will not be used for training the model.

#What are the missing values in the three datasets? 
install.packages("skimr")
library(skimr)
skim(Transactions)
summary(Transactions)
summary(Address)
summary(Demographics)
#Brand and Product details,job title and DOB were missing.
#Small number of records are empty, filter out record entirely, or if large number of records 
#are empty, or it is a core field, then impute it based on distribution in the training dataset. 

#Summary function can be used for understanding the factors of variables as well.