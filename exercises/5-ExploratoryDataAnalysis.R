library(tidyverse)
library(tidytext)
library(stringr)
library(plotly)

# This file looks and works a bit differently, because it is a regular `.r` file rather than an `.rmd` workbook. We've done this deliberately so we can talk about the kinds of R files you will more often encounter "in the wild." Because these files are not optimized for weaving together prose and code, there will be less explanatory text throughout this file, and we will have to discuss more in detail together. In brief, however, our goal in this lesson is to bridge between the kind of tabular data analysis we have been doing thus far toward text analysis and data visualization. We will overview a number of concepts in this lesson and then delve into each topic in more detail in tomorrow's workbooks.

# Let's import our CSV of US Newspaper titles

papers <- read_csv("./data/US-Newspapers.csv") %>%
  select(title, state, city, start, end, frequency, language) %>%
  filter(start != 9999) %>% 
  mutate(end = replace(end, end == 9999, 2014)) %>%
  mutate(frequencyReg = str_replace_all(frequency, "(^[A-Z][a-z]*)([.,-; ]{1,})(.*)", "\\1")) %>%
  unique()

# how many weekly newspapers were founded over time?

ggplot(papers %>% filter(frequency == "Weekly")) + geom_histogram(aes(x=start), bins=50)

# can we compare the growth of various frequencies over time?

ggplot(papers %>% filter(frequency %in% c("Weekly","Daily","Biweekly","Semiweekly"))) + 
  geom_histogram(aes(x=start), bins=50) + 
  facet_wrap(~ frequency, ncol=2) 

# what other aspects of this data might you visualize in a histogram?

# for some analyses and visualizations, years might be too granular a measure. Can you use techniques we've already discussed to create two new columns: `startDecade` and `endDecade`?

# in the code below, we will use `filter` and `ggplot` to explore some trends in our `papers` dataframe. This is similar to what we did in workbook 3, but we are incorporating basic visualizations in order to more easily spot trends in aggregate. 

papers %>% 
  filter(startDecade >= 1950 & startDecade <= 1980 ) %>%
  ggplot(aes(x=start)) +
  geom_histogram(bins=20)

papers %>% 
  filter(language == "ger") %>% 
  ggplot() + 
  geom_histogram(aes(x=start), bins=50)

# you might not be interested in the languages we have written a filter for below. How would you figure out what the other languages in the dataset are? Can you edit the code to filter for your chosen languages?

languages <- c("ger","fre","spa","chi")

papers %>% 
  filter(language %in% languages) %>%
  ggplot() +
  geom_histogram(aes(x=start), bins=50) + 
  facet_wrap(~ language, ncol=2) 


# In the following sections, we will begin introducing basic text analysis and discussing how such techniques might illuminate even a dataset like our `papers`, which do not include long text segements. Tomorrow we will work with lengthier texts. 

# top words in newspaper titles, sorted by frequency
papers %>% 
  unnest_tokens(word, title) %>% 
  anti_join(stop_words) %>%
  group_by(start, word) %>% 
  summarize(count = n()) %>%
  arrange(desc(count)) %>%
  View()

# create a custom stopwords list of only words common in newspaper titles (including other languages)
stopWords <- as_data_frame(c("the", "an", "and", "der", 
                             "die", "das", "und", "of",
                             "in","aus","dem","or")) %>%
  rename(word = value)

# top n words in newspaper titles, sorted by start decade
papers %>% 
  unnest_tokens(word, title) %>%
  anti_join(stopWords) %>%
  group_by(startDecade, word) %>% 
  summarize(count = n()) %>%
  arrange(startDecade,desc(count)) %>%
  top_n(10) %>%
  View()

titleWords <- papers %>% 
  unnest_tokens(word, title) %>%
  anti_join(stopWords) %>%
  group_by(startDecade, word) %>% 
  summarize(count = n()) %>%
  mutate(percentage = count / sum(count)) %>%
  mutate(decadeCount = length(startDecade)) %>%
  arrange(startDecade,desc(count))

# plot top words since 1800; why is this not useful?

titleWords %>% 
  filter(startDecade >= 1800) %>%
  ggplot(aes(x=percentage,y=startDecade,label=word)) + 
  geom_point(alpha=.3) + 
  geom_text(check_overlap = TRUE)

# create percentage column
newPapers <- papers %>% 
  group_by(startDecade) %>%
  summarise(newPapers = n())

# Can you write code that will use `newPapers` above to create a new column in `titleWords` that records the percentage of titles in which each word appears by decade?


# Now let's introduce some more sophsticated plots to explore these title words

plot <- titleWords %>%
  filter(startDecade >= 1800 & startDecade <= 1950) %>%
  top_n(3) %>% 
  filter(percentage >= .02) %>%
  ggplot(aes(x=startDecade, y=percentage, color = word)) +
  geom_line() +
  geom_point(size = .3) +
  ggtitle("Most Used Words in New Newspaper Titles by Decade, 1800-1950") +
  labs(x="Decades",y="Percentage of Titles",fill="Word",caption="The top words used in the titles of new newspapers during the nineteenth century by decade") + 
  theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=18, hjust=0.5)) +
  theme(axis.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=14)) + 
  theme(legend.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=14)) +
  theme(legend.background = element_rect(color = "#efefef")) +
  theme(plot.caption = element_text(family = "Trebuchet MS", color="#666666", size=10, hjust = 0.5, margin = margin(15, 0, 15, 0))) +
  theme(axis.text = element_text(family = "Trebuchet MS", color="#aaaaaa", face="bold", size=10)) +
  theme(panel.background = element_rect(fill = "white")) +
  theme(panel.grid.major = element_line(color = "#efefef")) +
  theme(axis.ticks = element_line(color = "#efefef"))

ggplotly(plot)


# In the space below, can you replicate what we did above by decade, but by year instead?




# The code below will take a little while to run, because it is using the start and end dates for each paper to calculate something more complex: in what years was each paper extant? Because this is pretty data intensive, we are only calculating these values for the nineteenth-century newspapers in the dataset. 

extantPapers <- papers %>% 
  filter(start >= 1800 & start <= 1900) %>%
  rowwise() %>%
  do(data.frame(title = .$title, frequency = .$frequency, year = seq(.$start, .$end))) %>%
  filter(year <= 1900)

# plot changes in number of papers over time

extantPapersByYear <- extantPapers %>% 
  group_by(year) %>%
  summarise(extantPapers = n())

plot <- extantPapersByYear %>%
  ggplot(aes(x=year, y=extantPapers)) +
  geom_line() +
  geom_point(size = .3) +
  ggtitle("Number of Extant Newspapers by Year in US History") +
  labs(x="Years",y="Number of Extant Papers",caption="Number of papers in existence 1689-2014") + 
  theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=18, hjust=0.5)) +
  theme(axis.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=14)) + 
  theme(legend.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=14)) +
  theme(legend.background = element_rect(color = "#efefef")) +
  theme(plot.caption = element_text(family = "Trebuchet MS", color="#666666", size=10, hjust = 0.5, margin = margin(15, 0, 15, 0))) +
  theme(axis.text = element_text(family = "Trebuchet MS", color="#aaaaaa", face="bold", size=10)) +
  theme(panel.background = element_rect(fill = "white")) +
  theme(panel.grid.major = element_line(color = "#efefef")) +
  theme(axis.ticks = element_line(color = "#efefef"))

ggplotly(plot)

# Once you run the code below, work to modify it meaningfully. Can you adjust the code above creating `extantPapers` and the plot below to find moments in which more daily papers were extant than weekly (or at least when the comparison is closer)?

extantPapers %>% 
  filter(year > 1850 & year <= 1870 & frequency %in% c("Weekly","Daily")) %>%
  ggplot() + 
  geom_histogram(aes(x=year), bins=20) + 
  facet_wrap(~ frequency, ncol=2) 

# Explore words in paper titles over time

extantTitleWords <- extantPapers %>% 
  unnest_tokens(word, title) %>% 
  anti_join(stopWords) %>%
  group_by(year, word) %>% 
  summarize(count = n()) %>%
  arrange(year,desc(count))

extantTitleWords <- extantTitleWords %>%
  left_join(extantPapersByYear, by = "year") %>%
  mutate(percentage = count/extantPapers)

plot <- extantTitleWords %>%
  filter(year >= 1800 & year <= 1950) %>%
  arrange(year,desc(percentage)) %>%
  top_n(10) %>%
  ggplot(aes(x=year, y=percentage, color = word)) +
  geom_line() +
  geom_point(size = .3) +
  ggtitle("Most Used Words in Extant Newspaper Titles by Year, 1800-1950") +
  labs(x="Years",y="Percentage of Titles",fill="Word",caption="The top words used in the titles of extant newspapers during the nineteenth century by decade") + 
  theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=18, hjust=0.5)) +
  theme(axis.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=14)) + 
  theme(legend.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=14)) +
  theme(legend.background = element_rect(color = "#efefef")) +
  theme(plot.caption = element_text(family = "Trebuchet MS", color="#666666", size=10, hjust = 0.5, margin = margin(15, 0, 15, 0))) +
  theme(axis.text = element_text(family = "Trebuchet MS", color="#aaaaaa", face="bold", size=10)) +
  theme(panel.background = element_rect(fill = "white")) +
  theme(panel.grid.major = element_line(color = "#efefef")) +
  theme(axis.ticks = element_line(color = "#efefef"))

ggplotly(plot)


# Plotting the top 10 newspaper title words by decade

titleWords %>% 
  filter(startDecade >= 1840 & startDecade < 1900) %>%
  group_by(startDecade) %>%
  top_n(5) %>%
  ggplot() + 
  geom_col(aes(x=word, y=percentage, fill=word)) + 
  coord_flip() +
  facet_wrap(~ startDecade, ncol=2) 

# or focus on particular decades 

decadeToSearch <- 1850

extantTitleWords %>% 
  filter(year >= decadeToSearch & year < decadeToSearch + 9) %>%
  top_n(5) %>%
  ggplot() + 
  geom_col(aes(x=word, y=percentage, fill=word)) + 
  coord_flip()

# compare particular words

compareWords <- list("telegraph","post")

plot <- extantTitleWords %>% 
  filter(word %in% compareWords & year >= 1840 & year < 1900) %>%
  ggplot(aes(x=year, y=count, color = word)) +
  geom_line() +
  geom_point(size = .3) +
  ggtitle("Most Used Words in Extant Newspaper Titles by Year, 1800-1950") +
  labs(x="Years",y="Percentage of Titles",fill="Word",caption="The top words used in the titles of extant newspapers during the nineteenth century by decade") + 
  theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=18, hjust=0.5)) +
  theme(axis.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=14)) + 
  theme(legend.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=14)) +
  theme(legend.background = element_rect(color = "#efefef")) +
  theme(plot.caption = element_text(family = "Trebuchet MS", color="#666666", size=10, hjust = 0.5, margin = margin(15, 0, 15, 0))) +
  theme(axis.text = element_text(family = "Trebuchet MS", color="#aaaaaa", face="bold", size=10)) +
  theme(panel.background = element_rect(fill = "white")) +
  theme(panel.grid.major = element_line(color = "#efefef")) +
  theme(axis.ticks = element_line(color = "#efefef"))

ggplotly(plot)

# Exercises

TBA!