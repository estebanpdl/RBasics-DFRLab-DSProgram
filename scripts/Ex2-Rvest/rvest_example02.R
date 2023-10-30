# ========================= #
#     import libraries      #
# ========================= #

library(rvest)

# Read URL
novaresistencia <- read_html("https://novaresistencia.org/")

# Collect articles -> Inspect elements on website
novaresistencia_articles <- novaresistencia %>%
  html_elements("h2.entry-title") %>%
  html_element("a")

# Collect picture attributes
novaresistencia_attrs <- html_attr(novaresistencia_articles, name = "href")

# Create a DataFrame
df_novaresistencia <- data.frame(novaresistencia_attrs)

# Save attrs
write.csv(df_novaresistencia, "data/novaresistencia_articles.csv", fileEncoding = "UTF-8")
