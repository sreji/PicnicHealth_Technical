library(dplyr)
library(ggplot2)
library(kableExtra)
library(tidyr)

## Read in the weather data and fix the data time formatting
## Split the hour/min/sec for further analysis
## Filtering the dates that are only in both weather and bike data
weather_data = read.csv("/Users/sreji/Documents/PicnicHealth_Technical/data/sf_weather.csv") %>%
  mutate(ymd = as.Date(DATE)) %>%
  filter(ymd >= '2017-06-28' & ymd <= '2018-05-05') %>% 
  mutate(hour = unclass(as.POSIXlt(DATE)$hour), min = unclass(as.POSIXlt(DATE)$min),sec = unclass(as.POSIXlt(DATE)$sec))

## Function to split the date time for the bike data
split_date = function(file) {
  file %>%
    mutate(start_ymd = as.Date(start_time),end_ymd = as.Date(end_time)) %>%
    filter(start_ymd >= '2017-06-28' & end_ymd <= '2018-05-05') %>% 
    mutate(start_hour = unclass(as.POSIXlt(start_time)$hour), start_min = unclass(as.POSIXlt(start_time)$min),start_sec = unclass(as.POSIXlt(start_time)$sec)) %>%
    mutate(end_hour = unclass(as.POSIXlt(end_time)$hour), end_min = unclass(as.POSIXlt(end_time)$min),end_sec = unclass(as.POSIXlt(end_time)$sec))
}

## Read in the bike data and fix the date time formatting 
bike_2017 = read.csv("/Users/sreji/Documents/PicnicHealth_Technical/data/bike_2017.csv") %>%
  split_date(.)
bike_201801 = read.csv("/Users/sreji/Documents/PicnicHealth_Technical/data/bike_201801.csv") %>%
  split_date(.)
bike_201802 = read.csv("/Users/sreji/Documents/PicnicHealth_Technical/data/bike_201802.csv") %>%
  split_date(.)
bike_201803 = read.csv("/Users/sreji/Documents/PicnicHealth_Technical/data/bike_201803.csv") %>%
  split_date(.)
bike_201804 = read.csv("/Users/sreji/Documents/PicnicHealth_Technical/data/bike_201804.csv") %>%
  split_date(.)
bike_201805 = read.csv("/Users/sreji/Documents/PicnicHealth_Technical/data/bike_201805.csv") %>%
  split_date(.)

## Combine bike data 
bike_data = bike_2017 %>% full_join(., bike_201801) %>%
  full_join(., bike_201802) %>% 
  full_join(., bike_201803) %>%
  full_join(., bike_201804) %>% 
  full_join(., bike_201805) 


