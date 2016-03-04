library(readr)
library(ggplot2)
library(lubridate)

IBM_URL <- "http://data210g.github.io/web/dl/ibm.csv"

ibm <- read_csv(IBM_URL)

str(ibm)

ibm %>% mutate(date=dmy(date)) -> ibm

str(ibm)

# POINTS ------------------------------------------------------------------

gg <- ggplot(data=ibm,
             mapping=aes(x=date, y=open))
gg <- gg + geom_point(stat="identity")
gg

# LINES -------------------------------------------------------------------

gg <- ggplot(data=ibm,
             mapping=aes(x=date, y=open))
gg <- gg + geom_line(stat="identity")
gg

# BOTH --------------------------------------------------------------------

gg <- ggplot(data=ibm,
             mapping=aes(x=date, y=open))
gg <- gg + geom_line()
gg <- gg + geom_point()
gg

# MORE THAN ONE COLUMN ----------------------------------------------------

gg <- ggplot(data=ibm, 
             mapping=aes(x=date))
gg <- gg + geom_line(mapping=aes(y=open))
gg <- gg + geom_line(mapping=aes(y=high))
gg <- gg + geom_line(mapping=aes(y=close))
gg

gg <- ggplot(data=ibm, 
             mapping=aes(x=date))
gg <- gg + geom_line(mapping=aes(y=open), color="maroon")
gg <- gg + geom_line(mapping=aes(y=high), color="steelblue")
gg <- gg + geom_line(mapping=aes(y=close), color="forestgreen")
gg

# WE CAN DO BETTER --------------------------------------------------------

ibm %>% 
  select(-volume) %>% 
  gather(measure, value, -date) -> ibm_long

str(ibm_long)

gg <- ggplot(data=ibm_long,
             mapping=aes(x=date, y=value))
gg <- gg + geom_point(mapping=aes(color=measure))
gg 

# ggplot is too smart for it's own good 

gg <- ggplot(data=ibm_long,
             mapping=aes(x=date, y=value))
gg <- gg + geom_line(mapping=aes(color=measure))
gg 

# make no assumptions about the grouping

gg <- ggplot(data=ibm_long,
             mapping=aes(x=date, y=value, group=measure))
gg <- gg + geom_line(mapping=aes(color=measure))
gg 

# FACETS ------------------------------------------------------------------

gg <- ggplot(data=ibm_long,
             mapping=aes(x=date, y=value, group=measure))
gg <- gg + geom_line(mapping=aes(color=measure))
gg <- gg + facet_wrap(~measure, ncol=1)
gg 

# BACK TO BARS ------------------------------------------------------------

gg <- ggplot(data=ibm,
             mapping=aes(x=date, y=volume)) 
gg <- gg + geom_bar(stat="identity")
gg







