# Solutions for Worksheet 2 Exercises

# 2

census <- read.csv(file="./data/1840-census-data.csv")[ , c("QualifyingAreaName", "Newspapers", "Newspapers_Daily", "Newspapers_Weekly", "Newspapers_SemiTriWeekly", "Periodicals", "PrintingOffices")]
census <- rename(census, county = QualifyingAreaName)
census_long <- gather(census, "publication_type", "count", 2:7)
census_long <- separate(census_long, county, into = c("county", "state"), sep = "\\, ")
census_long <- na.omit(census_long)

# 3

census <- read_csv(file="./data/1840-census-data.csv")
census <- rename(census, county = QualifyingAreaName)
census <- separate(census, county, into = c("county", "state"), sep = "\\, ")
census <- group_by(census, state)
literate <- summarize(census, totalLit = sum(LiterateWhiteAge20andOver))
literate <- arrange(literate, desc(totalLit))

census <- read_csv(file="./data/1840-census-data.csv")
census <- rename(census, county = QualifyingAreaName)
census <- separate(census, county, into = c("county", "state"), sep = "\\, ")
census <- group_by(census, state)
literate <- summarize(census, totalLit = sum(LiterateWhiteAge20andOver) / sum(TotalPopulation))
literate <- arrange(literate, desc(totalLit))

# 4 

