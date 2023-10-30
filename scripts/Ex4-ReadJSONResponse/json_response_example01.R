# ========================= #
#     install packages      #
# ========================= #

# install.packages("tidyverse")
# install.packages("rjson")



# ========================= #
#     import libraries      #
# ========================= #

library(rjson)
library(tibble)
library(tidyverse)

# read YouTube Postman response
result <- fromJSON(file = "data/json-response/response-youtube-videos.json")
res <- tibble(data_content = result$items)

res %>% 
  unnest_wider(data_content)

res %>% 
  unnest_wider(data_content) %>% 
  select(
    kind, etag, id, snippet
  ) -> output


# get videos
videos <- output$snippet
videos <- tibble(video_content = videos)


# ============= #
#     Test      #
# ============= #
videos %>% 
  unnest_wider(video_content)


# ============== #
#     Apply      #
# ============== #
videos %>% 
  unnest_wider(video_content) %>% 
  select(
    publishedAt, channelId, title, description, thumbnails, channelTitle,
    liveBroadcastContent, publishTime
  ) -> video_data

# get video ids
video_data <- video_data %>%
  mutate(videoId = map_chr(output$id, ~.x$videoId))


# grab thumbnails
video_data <- video_data %>%
    mutate(high_thumbnail_url = map_chr(thumbnails, ~.x$high$url))

# write dataset in CSV
video_data <- apply(video_data, 2, as.character)
video_csv_file <- './data/video_content.csv'
write.csv(video_data, file = video_csv_file, fileEncoding = "UTF-8")


# Define a directory to save the images
save_dir = './data/youtube_thumbnails'
if (!dir.exists(save_dir)) {
  dir.create(save_dir, recursive = TRUE)
}

# Download and save the thumbnails locally
walk2(video_data$high_thumbnail_url, video_data$videoId, function(url, vid) {
  download.file(
    url = url,
    destfile = file.path(save_dir, paste0("thumbnail_", vid, ".jpg")),
    mode = "wb"
  )
})
