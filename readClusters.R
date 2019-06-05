library(tidyverse)

readClusters <- function(Ipath){
  f <- list.files(path = Ipath, full.names = TRUE, pattern = ".*csv.gz")
  for (i in f){
    df <- read_csv(i)
    df <- df %>%
      select(cluster, size, date, source, placeOfPublication, corpus, text, url) %>%
      group_by(cluster) %>%
      slice(1) %>%
      mutate(text = str_replace_all(text, '[:punct:]', "")) %>%
      ungroup()
  }
  return(df)
}
