# Install and Import Rvest / urltools library

# install.packages("rvest")
# install.packages('urltools')
library(rvest)
library(urltools)

# Read URL
onpress <- read_html("https://onpress.pl/")

# Collect articles -> Inspect elements on website
articles <- onpress %>% html_elements("article") %>%
  html_element("a")

# Collect links
attrs <- html_attr(articles, name = "href")

# Create a DataFrame
df_attrs <- data.frame(attrs)
df_attrs$domain <- domain(df_attrs$attrs)

# Save attrs
write.csv(df_attrs, "data/onpress_links.csv", fileEncoding = "UTF-8")
