# Install and Import Rvest library

# install.packages("rvest")
library(rvest)

# Read URL
rt <- read_html("https://actualidad.rt.com/")

# Collect articles -> Inspect elements on website
rt_articles <- rt %>% html_elements("article") %>%
  html_element("a")

# Collect picture attributes
rt_attrs <- html_attr(rt_articles, name = "href")

# Create a DataFrame
df_rt <- data.frame(rt_attrs)

# Add text to each row: 'https://actualidad.rt.com'. Create a new column
df_rt$rt_links <- paste0("https://actualidad.rt.com", df_rt$rt_attrs)

# Save attrs
write.csv(df_rt, "data/rt_articles.csv", fileEncoding = "UTF-8")
