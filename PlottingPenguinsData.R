

# ---- The top of our RMarkdown file ----

library(tidyverse)
library(palmerpenguins)
library(here)
library(janitor)

# This means we can use our own functions from cleaning.R file.
source(here("functions", "cleaning.R"))
# -------------------------------------

# ---- Save the raw data ----
# This is commented out because we already have the raw data saved.
# write_csv(penguins_raw, here("data", "penguins_raw.csv"))
# -------------------------------------

# ---- Load the raw data ----
penguins_raw <- read_csv(here("data", "penguins_raw.csv"))
# -------------------------------------

# ---- Check column names ----  
colnames(penguins_raw)
# -------------------------------------

# ---- Cleaning the data ----
# We can use the functions from libraries like janitor and also 
# our own functions, like those in cleaning.R. 
# I've used a pipe %>% to chain the functions together. You can also make this
# into a function if you want to (functions within functions).
penguins_clean <- penguins_raw %>%
  clean_column_names() %>%
  remove_columns(c("comments", "delta")) %>%
  shorten_species() %>%
  remove_empty_columns_rows()
# -------------------------------------

# ---- Check the output ----
colnames(penguins_clean)
# -------------------------------------

# ---- Save the clean data ----
write_csv(penguins_clean, here("data", "penguins_clean.csv"))
# -------------------------------------

#exploratory figures
penguins_clean <- read_csv(here("data", "penguins_clean.csv"))

#need to deal with some of these missing values. 
#only remove missing values from the columns that we are interested in
#otherwise we remove more data than we need to

#subset the columns: species and flipper length
#penguins_flippers <- select(penguins_clean, c("species", "flipper_length_mm"))

#remove any nans
#penguins_flippers <- drop_na(penguins_flippers)

#this is bad code - we are overwrighting code, so we need to do a pioe instead
penguins_flippers <- penguins_clean %>%
  select(species,flipper_length_mm) %>%
           drop_na()

penguins_flippers

#make a boxplot of flipper data
species_colours <- c("Adelie"= "darkorange",
                     "Chinstrap" = "purple",
                     "Gentoo" = "cyan4")


flipper_boxplot <- ggplot(
  data = penguins_flippers,
  aes(x = species,
      y = flipper_length_mm)) + 
  geom_boxplot(aes(color = species),
               width = 0.3,
        show.legend = FALSE) + 
  geom_jitter(aes(color = species),
              alpha = 0.3,
              show.legend = FALSE,
              position = position_jitter(
                width = 0.2,
                seed = 0)) +
  scale_color_manual(values = species_colours) +
  labs(x = "Penguin species",
       y = "Flipper length (mm)") +
  theme_bw()

flipper_boxplot
###

#now we want to turn it into a function, so we don't have to copy and paste code
#make a new file called 'plotting' in the 'functions' folder

source(here("functions", "plotting.R"))

git config --global user.name "HannahGlendell"
git config --global user.email "hannah.glendell@worc.ox.ac.uk"

