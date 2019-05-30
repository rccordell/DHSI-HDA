library(tidyverse)

topWords <- function(x, decade1, decade2, nwords) {
  stopWords <- as_data_frame(c("the", "an", "and", "der", "die", 
                               "das", "und", "of", "in","aus","dem","or")) %>%
    rename(word = value)
  x %>%
    filter(startDecade >= decade1 & startDecade <= decade2) %>%
    unnest_tokens(word, title) %>%
    anti_join(stopWords) %>%
    group_by(startDecade, word) %>% 
    summarize(count = n()) %>%
    arrange(startDecade,desc(count)) %>%
    top_n(nwords)
}

allWords <- function(x, year1, year2) {
  y <- x %>% 
    filter(start >= year1 & start <= year2) %>%
    group_by(start) %>%
    summarise(newPapers = n())
  stopWords <- as_data_frame(c("the", "an", "and", "der", "die", 
                               "das", "und", "of", "in","aus","dem","or")) %>%
    rename(word = value)
  x %>%
    filter(start >= year1 & start <= year2) %>%
    unnest_tokens(word, title) %>%
    anti_join(stopWords) %>%
    group_by(start, word, startDecade, end) %>% 
    summarize(count = n()) %>%
    ungroup() %>%
    group_by(start) %>% 
    left_join(y, by = "start") %>%
    mutate(percentage = count/newPapers) %>%
    arrange(start, desc(percentage), desc(count))
}
