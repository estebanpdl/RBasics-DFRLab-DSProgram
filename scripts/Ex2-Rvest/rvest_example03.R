# ========================= #
#     import libraries      #
# ========================= #

library(rvest)

# Read URL
url <- read_html("https://lopezobrador.org.mx/transcripciones/")

# Collect articles -> Inspect elements on website
content <- url %>% html_elements("article") %>%
  html_element("a")

# iterate each < a > element
for (i in 1:length(content)) {
    # Extract url
    href <- html_attr(content[[i]], name = "href")
    
    # Read HTML source
    tmp <- read_html(href)

    # Get text from < p > HTML elements
    text <- tmp %>% html_elements("p") %>%
      html_text()
    
    # save text to txt file
    writeLines(text, con = paste0("data/transcripts", i, ".txt"))
}
