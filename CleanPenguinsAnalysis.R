#this is the clean version


library(tidyverse)
library(palmerpenguins)
library(janitor)
library(here)

#loading our function file
source(here("functions", "cleaning.R"))

#this tells it to save it as a csv
penguins_raw <- read.csv(here("data", "penguins_raw.csv"))

#this creates a pipe, so that you can do lots of steps in one function
#the raw_data just tells it to do the function on any dataset
cleaning_penguin_column <- function(raw_data){
  print("Cleaned names, removed comments, removed empty rows and cols, removed delta")
  raw_data %>%
    clean_names() %>%
    shorten_species() %>%
    remove_empty(c("rows", "cols")) %>%
    select(-starts_with("delta"))
}

#this just prints the column names
colnames(penguins_raw)

#apply the new function that we created, to make a new variable called 'penguins clean'
penguins_clean <- cleaning_penguin_column(penguins_raw)

#print the column names to check it has all worked
colnames(penguins_clean)

####################################################################
#renv is a cool thing and this is code for how to use it
#this shoudl go in the consol, but I just wanted a copy
#initialise renv
install.packages(renv)
renv::init()
renv::diagnostics()
renv::snapshot()#what packages you have

renv::install("table 1")

#use the renv folder to install all the right libraries
renv::restore()
