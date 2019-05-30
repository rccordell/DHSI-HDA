library(tidyverse)
library(stringr)

papers <- read_csv("./data/US-Newspapers.csv") %>%
  select(title, state, city, start, end, frequency, language) %>%
  filter(start != 9999) %>% 
  mutate(end = replace(end, end == 9999, 2014)) %>%
  mutate(frequencyReg = str_replace_all(frequency, "(^[A-Z][a-z]*)([.,-; ]{1,})(.*)", "\\1")) %>%
  mutate(startDecade = str_sub(start, 1, 3)) %>%
  mutate(startDecade = as.numeric(paste(startDecade, 0, sep=""))) %>%
  mutate(endDecade = str_sub(end, 1,3)) %>%
  mutate(endDecade = as.numeric(paste(endDecade, 0, sep=""))) %>%
  unique()
