library(readr)
library(tidyr)
library(dplyr)
library(ggplot2)

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

voting %>% 
  gather(stat, value, -state) %>% 
  separate(stat, into=c("kind", "year"), sep="_") %>% 
  mutate(value=value/100) -> voting_long

# PRACTICE PLOTTING -------------------------------------------------------

gg <- ggplot(data=voting,
             mapping=aes(x=state, y=voted_2012))
gg <- gg + geom_bar(stat="identity")
gg

gg <- ggplot(data=voting,
             mapping=aes(x=state, y=voted_2012))
gg <- gg + geom_bar(stat="identity")
gg <- gg + coord_flip()
gg

# PRACTICE: look at the ggplot2 online help and see if you can
#           figure out a way to change the axis labels (or remove them)

# PRACTICE: add a title to the plot

# PRACTICE: change the colors of the bars

# PRACTICE: look at the ggplot2 online help and figure out how to
#           change the theme of the plot

# SORTED BARS -------------------------------------------------------------

voting %>% arrange(desc(voted_2012)) -> voting_sorted

str(voting_sorted$state)

voting_sorted %>% 
  mutate(state=factor(state, levels=state)) -> voting_sorted

str(voting_sorted$state)

levels(voting_sorted$state)

gg <- ggplot(data=voting_sorted,
             mapping=aes(x=state, y=voted_2012))
gg <- gg + geom_bar(stat="identity")
gg <- gg + coord_flip()
gg

# SORTING THE OTHER WAY ROUND ---------------------------------------------

voting %>% 
  arrange(voted_2012) %>% 
  mutate(state=factor(state, levels=state)) %>% 
  ggplot(mapping=aes(x=state, y=voted_2012)) -> gg

gg <- gg + geom_bar(stat="identity")
gg <- gg + coord_flip()
gg


