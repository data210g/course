library(readr)
library(tidyr)
library(dplyr)

URL <- "http://data210g.github.io/web/dl/voting.csv"

voting <- read_csv(URL, skip=7, col_names=FALSE,
                   n_max=51)

years <- c(2012, 2008, 2004, 2000, 1996, 1992, 1988)
years <- rep(years, each=2)

voting_types<- c("voted", "registered")
data_cols <- paste(voting_types, "_", years, sep="")
new_names <- c("state", data_cols)


voting <- voting[, 1:length(new_names)]
voting <- setNames(voting, new_names)

# LONG FORMAT -------------------------------------------------------------

voting_long <- gather(voting, stat, value, -state)
voting_long <- separate(voting_long, stat, into=c("kind", "year"), sep="_")
voting_long$value <- voting_long$value / 100

# ALTERNATE WAY WITH mutate -----------------------------------------------

voting_long <- gather(voting, stat, value, -state)
voting_long <- separate(voting_long, stat, into=c("kind", "year"), sep="_")
voting_long <- mutate(voting_long, value=value / 100)

# NEW OPERATOR ------------------------------------------------------------

mutate(separate(gather(voting, stat, value, -state), 
                stat, into=c("kind", "year"), sep="_"), 
       value=value / 100)


voting %>% 
  gather(stat, value, -state) %>% 
  separate(stat, into=c("kind", "year"), sep="_") %>% 
  mutate(value=value/100) -> voting_long


