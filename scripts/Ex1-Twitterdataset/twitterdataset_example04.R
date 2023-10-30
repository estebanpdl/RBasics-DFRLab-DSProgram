# ========================= #
#     install packages      #
# ========================= #

# install.packages('tidyverse')



# ========================= #
#     import libraries      #
# ========================= #

library(tidyverse)

# Creating a new column based on one condition
data$is.retweet = ifelse(str_starts(data$Tweet.text, 'RT @'), 1, 0)
