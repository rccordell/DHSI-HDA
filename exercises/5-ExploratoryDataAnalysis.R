library(tidyverse)
library(tidytext)
library(stringr)
library(plotly)

# This file looks different and works a bit differently, because it is a regular `.r` file rather than an `.rmd` workbook. We've done this deliberately so we can talk about the kinds of R files you will more often encounter "in the wild." These files are not optimized for weaving together prose and code: all explanatory prose has to be marked with `#` to designate it as a "comment" that R will not attempt to execute. Thus there will be less explanatory text throughout this file, and we will have to discuss more in detail verbally. In brief, however, our goal in this lesson is to bridge between the kind of tabular data analysis we have been doing thus far toward text analysis and data visualization. We will overview a number of concepts in this lesson and then delve into each topic in more detail in tomorrow's workbooks.

# Let's import our CSV of US Newspaper titles

papers <- read_csv("./data/US-Newspapers.csv") %>%
  select(title, state, city, start, end, frequency, language) %>%
  filter(start != 9999) %>% 
  mutate(end = replace(end, end == 9999, 2014)) %>%
  mutate(frequencyReg = str_replace_all(frequency, "(^[A-Z][a-z]*)([.,-; ]{1,})(.*)", "\\1")) %>%
  unique()

# how many weekly newspapers were founded over time?

papers %>%
  filter(frequencyReg == "Weekly") %>%
  ggplot(aes(x=start)) + 
  geom_histogram(bins=50)

# for some analyses and visualizations, years might be too granular a measure. Can you use techniques we've already discussed to create two new columns: `startDecade` and `endDecade`?

YOUR CODE HERE

# This is actually a good time to take a detour and discuss a distinction between these workbooks, even this one written as an `.R` file, and the way people usually work in R. A typical R file is a script written to accomplish a particular task. Some are certainly exploratory, and might meander, overwrite variable, and so on as we've done here, but many are short and written to accomplish one particular thing. R files can also be invoked within other R files, so that you can write code in modular ways and then use particular scripts within other scripts as needed. Those other scripts can be invoked using `source()`. If you look at your files, you will find one named `readPapers.R` in the base directory. We can invoke that file in this file like this:

source("readPapers.R")

# This script loads several necessary packages and then imports the newspaper data we've been working with today, complete with all of the transformations we have written for it. If this was a data source we worked with frequently, it might make sense to write a short import script like this and simply invoke it when needed, rather than copying and pasting (or rewriting) all of this code every time we need it. If we needed to make changes to the way we imported the data, we could simply change the `readPapers.R` file and those changes would take effect in every other file where we invoke that script using `source`. This kind of workflow becomes particularly important when you start to write your own functions, as we will discuss below. 





# Can you use methods from previous workbooks to create a new dataframe (either as a new variable or in a temporary one created by `View`) that would help us compare the prevalence of different publication frequencies at different moments of time?

YOUR CODE HERE

# As we will see in the next two days, another way to explore these questions, particularly at scale, is through R's visualization libraries. Here's some code that gets at some of the same questions as what you wrote above. Can you tell the difference between the first and second visualization? We will delve into these details more tomorrow, but we can chat about it today. Once you've run this code, try modifying it to compare different frequencies, or to focus on only one of interest:

papers %>% 
  filter(frequencyReg %in% c("Daily","Biweekly","Semiweekly")) %>%
  ggplot(aes(x = start, fill = frequencyReg, color = "white")) + 
  geom_histogram(bins = 50, position = "identity")

papers %>% 
  filter(frequencyReg %in% c("Daily","Biweekly","Semiweekly")) %>%
  ggplot(aes(x = start, fill = frequencyReg, color = "white")) + 
  geom_histogram(bins = 50, position = "stack")

# Alternatively, we could do something like this:

papers %>% 
  filter(frequencyReg %in% c("Weekly","Daily","Biweekly","Semiweekly")) %>%
  ggplot(aes(x = start)) + 
  geom_histogram(bins = 50, color = "darkblue", fill = "lightblue") + 
  facet_wrap(~ frequencyReg, ncol=2) 

# what other aspects of this data might you visualize in a histogram?

YOUR CODE HERE

# in the code below, we will use `filter` and `ggplot` to explore some trends in our `papers` dataframe. This is similar to what we did in workbook 3, but we are incorporating basic visualizations in order to more easily spot trends in aggregate. 

papers %>% 
  filter(startDecade >= 1950 & startDecade <= 1980 ) %>%
  ggplot(aes(x=start)) +
  geom_histogram(bins=20)

papers %>% 
  filter(language == "ger") %>% 
  ggplot() + 
  geom_histogram(aes(x=start), bins=50)

# We've filtered for some languages below. How would you figure out what the other languages in the dataset are? Can you edit the code to filter for other languages you might find of interest, should they differ?

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
stopWords <- as_data_frame(c("the", "an", "and", "der", "die", 
                             "das", "und", "of", "in","aus","dem","or")) %>%
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

# Let's take a detour here to talk about another useful feature of R, which is the ease with which you can write your own functions. If you look at `topWords.R` in your files menu, we can talk about how that function gives us an easy way to explore the dynamics of word usage above. 

source("topWords.R")

topWords(papers,1800,1900,10) %>% View()


# Let's plot the top words in newspaper titles betwee 1800 and 1950. What major limitation(s) do you spot with this visualization?

titleWords <- topWords(papers,1800,1950,10) 

titleWords %>%
  ggplot(aes(x=startDecade,y=count,label=word)) + 
  geom_point(alpha=.3) + 
  geom_text(check_overlap = TRUE)
  

# Without giving away the problem we identified above, can you write code that will result in `topWords.R` creating a new column that would be better for the comparisons we want to make? Then can you modify the plot above to make use of that new column? 

titleWords <- topWords(papers,1800,1950,10) 

titleWords %>%
  ggplot(aes(x=startDecade,y=percentage,label=word)) + 
  geom_point(alpha=.3) + 
  geom_text(check_overlap = TRUE)


# Now let's introduce some more sophsticated plots to explore these title words.

plot <- titleWords %>%
  # top_n(3) %>% 
  ggplot(aes(x=startDecade, y=percentage, color = word)) +
  geom_line() +
  geom_point(size = .3) +
  ggtitle(paste("Most Used Words in New Newspaper Titles by Decade, ", min(titleWords$startDecade), "-", max(titleWords$startDecade))) +
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


# In the space below, can you replicate what we did above not by decade, but by year instead?




# The code below will take a little while to run, because it is using the start and end dates for each paper to calculate something more complex: in what years was each paper extant? Because this is pretty data intensive, we are only calculating these values for the nineteenth-century newspapers in the dataset. 


dateRange <- c(1800,1900)

extantPapers <- papers %>% 
  filter(start >= dateRange[1] & start <= dateRange[2]) %>%
  filter(end > start) %>%
  rowwise() %>%
  do(data_frame(title = .$title, frequency = .$frequency, year = seq(.$start, .$end))) %>%
  filter(year <= 2000)

# plot changes in number of papers over time

plot <- extantPapers %>%
  group_by(year) %>%
  summarize(papers = n()) %>%
  ggplot(aes(x=year, y=papers)) +
  geom_line() +
  geom_point(size = .3) +
  ggtitle("Number of Extant Newspapers by Year in US History") +
  labs(x="Years",y="Number of Extant Papers",caption = paste("Number of papers in existence, ", min(extantPapers$year), "-", max(extantPapers$year))) + 
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


# Ok, looking at the code below, we would like you to work to modify it meaningfully. Can you adjust the code above creating `extantPapers` to look at different time periods, or compare different frequencies (or other features) in search of a meaningful juxtaposition? Can you convert any of this to a function (or functions) to streamline the processes?

dateRange <- c(1850,1870)
pubFrequencies <- c("Weekly","Daily")

extantPapers %>% 
  filter(year > dateRange[1] & year <= dateRange[2] & frequency %in% pubFrequencies) %>%
  ggplot() + 
  geom_histogram(aes(x=year), bins=20) + 
  facet_wrap(~ frequency, ncol=2) 

extantPapersByYear <- extantPapers %>% 
  group_by(year) %>%
  summarise(extantPapers = n())

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

# Let's focus on particular decades 

decadeToSearch <- 1840

extantTitleWords %>% 
  filter(year >= decadeToSearch & year < decadeToSearch + 9) %>%
  top_n(10) %>%
  ggplot() + 
  geom_col(aes(x=word, y=percentage, fill=word)) + 
  coord_flip()

# OR...

dateRange <- c(1840,1870)

extantTitleWords %>% 
  filter(year >= dateRange[1] & year <= dateRange[2]) %>%
  top_n(10) %>%
  ggplot() + 
  geom_col(aes(x=word, y=percentage, fill=word)) + 
  coord_flip() +
  facet_wrap(~ str_sub(year, 1, 3), ncol=2) 

# compare particular words

compareWords <- list("telegraph","post")

plot <- extantTitleWords %>% 
  filter(word %in% compareWords & year >= dateRange[1] & year <= dateRange[2]) %>%
  ggplot(aes(x=year, y=count, color = word)) +
  geom_line() +
  geom_point(size = .3) +
  ggtitle(paste("Comparison of \"", compareWords[1], "\" and \"", compareWords[2], "\" in US Newspapers, ", dateRange[1], "-", dateRange[2])) +
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
