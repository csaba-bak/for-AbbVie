library(tidyverse)
library(xml2)
library(rvest)

#read in the html file
raw_blood_type <- read_html("data/blood_type.html")

#select the tables
raw_tab_blood_type <- raw_blood_type %>% html_nodes("table")

#check and find the table we need
head(raw_tab_blood_type)

#create and check our table
tab <- raw_tab_blood_type[[2]]
tab <- tab %>% html_table
head(tab)

#name the columns
tab <- tab %>% setNames(c("Country","Population","0+","A+","B+","AB+","0-","A-","B-","AB-"))

#parse and clean the string and numbers
tab <- tab %>% mutate_at(2:10, parse_number)
tab <- tab %>% mutate_at(1, funs(str_replace_all(.,"\\[\\d*\\]$", "")))

#tidy data
pop_blood_type <- tab %>% select(Country, Population)
tidy_blood_type <- tab %>% select(-Population) %>% gather(-Country, key = "Blood_Type", value = "Percentage")

#save the processed data object in files
save(tidy_blood_type, file = "rda/tidy-blood-type-table.rda")
save(pop_blood_type, file = "rda/pop-blood-type-table.rda")