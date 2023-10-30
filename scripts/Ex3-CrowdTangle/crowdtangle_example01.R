# import modules
# install.packages("xlsx")
# install.packages("ini")
library(dplyr)
library(xlsx)
library(ini)

# read domains sample
df <- read.csv('./data/websites/domains_sample.csv')
urls <- df$link

# read api key token
config_file_path = "config/config.ini"
config <- read.ini(filepath = config_file_path)

# access the API token
api_token <- config$`Crowdtangle API credentials`$ct_token

# function -> CT links
ct_get_links_httr <- function(query.string, sleep_time=10) {
  res <- tryCatch(
    {
      httr::RETRY(
        verb = 'GET',
        url = query.string,
        times = 3,
        terminate_on = c(401),
        pause_base = sleep_time,
        pause_cap = 10,
        pause_min = sleep_time
      )
    },
    error=function(cond) {
      print(paste(cond, "on call:", query.string))
      write(paste("\n", cond, "on call:", query.string), file = "log.txt", append = TRUE)
      return(NA)
    }
  )
  
  status <- httr::status_code(res)
  print ('Status')
  print (status)
  print ('------')
  
  tryCatch(
    {
      if (status == 200L) {
        if (httr::http_type(res) != 'application/json') {
          stop("API did not return json", call. = FALSE)
        }
        
        response.json <- httr::content(
          res,
          as = 'text',
          type = 'application/json',
          encoding = 'UTF-8'
        )
        
        parsed <- jsonlite::fromJSON(response.json, flatten = TRUE)
        return(parsed)
      }
      else if (status == 429L) {
        message('API rate limit hit, sleeping...')
        write(paste("API rate limit hit on call:", res$url), file = "log.txt", append = TRUE)
        Sys.sleep(sleep_time)
        return(NA)
      }
      else if (status == 401L) {
        stop("Unauthorized, please check your API token...", call. = FALSE)
      }
      else {
        message(paste(res$status, res$url))
        write(paste("Unexpected http response code", res$status, "on call ", res$url), file = "log.txt", append = TRUE)
        return(NA)
      }
    },
    error = function(cond) {
      write(paste("Error:", message(cond), "on call:", res$url), file = "log.txt", append = TRUE)
      return(NA)
    }
  )
}

# create list -> store posts
url_datalist <- list()

# Iterate URLs
for (i in 1:NROW(urls)) {
  
  # parameters
  link <- urls[i]
  print (link)
  platforms = 'facebook'
  startDate = '2023-03-28'
  endDate = '2023-04-13'
  token = api_token
  count = 500
  
  endpoint.links <- "https://api.crowdtangle.com/links?"
  query.endpoint <- paste0(
    endpoint.links,
    "link=", link,
    "&platforms=", platforms,
    "&count=", count,
    "&startDate=", startDate,
    "&endDate=", endDate,
    "&token=", token
  )
  
  # posts
  resp <- ct_get_links_httr(query.string = query.endpoint)
  if (any(!is.na(resp))) {
    if (length(resp$result$posts) != 0) {
      url_datalist <- c(list(resp$result$posts), url_datalist)
      
      # paginate
      counter <- 1L
      while (counter <= 2 & !is.null(resp$result$pagination$nextPage)) {
        resp <- ct_get_links_httr(resp$result$pagination$nextPage, sleep_time = 30)
        counter <- sum(counter, 1)
        
        if (any(!is.na(resp))) {
          url_datalist <- c(list(resp$result$posts), url_datalist)
        }
        
        else break
      }
    }
  }
  
  cat('\n')
  Sys.sleep(10)
}

# Create a dataframe using url_datalist. do.call is not working
dataset <- bind_rows(url_datalist)

# save dataset XLSX format
xlsx_file <- './data/crowdtangle_output.xlsx'

# 2 specifies that as.character will be applied to each column of the dataset
dataset <- apply(dataset, 2, as.character)
write.xlsx(dataset, file = xlsx_file)

# write dataset in CSV
csv_file <- './data/crowdtangle_output.csv'
write.csv(dataset, file = csv_file, fileEncoding = "UTF-8")
