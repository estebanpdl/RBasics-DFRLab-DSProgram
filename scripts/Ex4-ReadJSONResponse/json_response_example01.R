# install packages
# install.packages("rjson")
library(rjson)
library(tibble)
library(tidyverse)

# read response
result <- fromJSON(file = "data/json-response/response-twitter-users.json")
res <- tibble(data_content = result)

res %>% 
  unnest_wider(data_content)


res %>% 
  unnest_wider(data_content) %>% 
  select(
    id, screen_name, name, location, description, url
  ) -> output
