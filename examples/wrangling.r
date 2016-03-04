library(readr)
library(tidyr)
library(dplyr)

URL <- "http://data210g.github.io/web/dl/voting.csv"


# ATTEMPT #1 --------------------------------------------------------------

voting <- read_csv(URL)






# ATTEMPT #2 --------------------------------------------------------------

voting <- read_csv(URL, skip=7)






# ATTEMPT #3 --------------------------------------------------------------

voting <- read_csv(URL, skip=7, col_names=FALSE)






# ATTEMPT #4 --------------------------------------------------------------

voting <- read_csv(URL, skip=7, col_names=FALSE,
                   n_max=51)






# BETTER COLUMN NAMES -----------------------------------------------------

voting <- read_csv(URL, skip=7, col_names=FALSE,
                   n_max=51)

years <- c(2012, 2008, 2004, 2000, 1996, 1992, 1988)
years <- rep(years, each=2)

voting_types<- c("voted", "registered")

data_cols <- paste(voting_types, "_", years, sep="")

new_names <- c("state", data_cols)


voting <- voting[, 1:length(new_names)]

colnames(voting) <- new_names

voting <- setNames(voting, new_names)

