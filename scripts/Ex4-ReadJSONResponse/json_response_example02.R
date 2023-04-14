# Load the jsonlite package
library(jsonlite)

# read response
json_file <- "data/json-response/response-wayback.json"
json_data <- jsonlite::read_json(json_file)

# Extract the column names from the first element of the list
col_names <- as.character(json_data[[1]])

# Convert the remaining elements of the list to a data frame
df <- as.data.frame(do.call(rbind, json_data[-1]))

# Set the column names of the data frame
colnames(df) <- col_names
