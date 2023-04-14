# Install and Import Rvest library

# install.packages("rvest")
library(rvest)

# Read URL
url <- read_html("https://lopezobrador.org.mx/transcripciones/")

# Collect articles -> Inspect elements on website
content <- url %>% html_elements("article") %>%
  html_element("a")

# iterate each < a > element
for (i in 1:length(content)) {
    # read url
    href <- html_attr(content[[i]], name = "href")
    tmp <- read_html(href)

    # get text from < p > elements
    text <- tmp %>% html_elements("p") %>%
      html_text()
    
    # save text to txt file
    writeLines(text, con = paste0("data/transcripts", i, ".txt"))
}
