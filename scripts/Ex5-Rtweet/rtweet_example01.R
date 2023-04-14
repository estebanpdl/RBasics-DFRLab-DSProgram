# === Getting data from Twitter ===

# Install and Import Rtweet library
# install.packages("rtweet")
library(rtweet)

# Get tweets by keyword/hashtag
tweets <- search_tweets("openai", n = 10000, include_rts = FALSE)

# Get users -> It takes more tweets basically. It seems keywords and hashtags with
# special characters are not supported.
usrs <- search_users("MAGA", n = 1000)

# Get friends -> accounts followed by one specific account
following <- get_friends("AlvaroUribeVel")

# Lookup data on those accounts
following_metadata = lookup_users(following$user_id)

# === Explore dataset ===
names(tweets)
dim(tweets)


# save dataset
csv_file <- './data/tweets_output.csv'
write.csv(tweets, file = csv_file, fileEncoding = "UTF-8")
