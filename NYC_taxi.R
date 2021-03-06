library(data.table)
library(dplyr)

# Read dataset
col <- c("tpep_pickup_datetime", "tpep_dropoff_datetime", "pickup_longitude", "pickup_latitude",
         "dropoff_longitude", "dropoff_latitude", 'trip_distance', 'fare_amount', 'tip_amount', 'total_amount')
yellow <- fread('yellow_tripdata_2015-06.csv', header = TRUE, select = col)

# Choose a sample from dataset
yellow_sample <- yellow[(yellow$tpep_pickup_datetime <= "2015-06-04 00:00:00") & (yellow$tpep_pickup_datetime >= "2015-06-03 00:00:00"),]
yellow_sample <- filter(yellow_sample, pickup_longitude != 0)
# Set Initial Location and Destination
# Time Square Latitude 40.7577, Longitude -73.9857
# Columbia University 40.8075, Longitude -73.9619
Ini_longitude <- -73.9857
Ini_latitude <- 40.7577

Des_longitude <- -73.9619
Des_latitude <- 40.8075

# Choose the sample has same pickup location and dropoff location
alpha <- 0.00002
yellow_sample_2 <- filter(yellow_sample, (((Ini_longitude - yellow_sample$pickup_longitude) ^ 2 + (Ini_latitude - yellow_sample$pickup_latitude) ^ 2) <= alpha) & (((Des_longitude - yellow_sample$dropoff_longitude) ^ 2 + (Des_latitude - yellow_sample$dropoff_latitude) ^ 2) <= alpha))

distance <- mean(yellow_sample_2$trip_distance)
tip <- mean(yellow_sample_2$tip_amount)
cost <- mean(yellow_sample_2$total_amount)

