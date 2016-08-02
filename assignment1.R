library(magrittr)
library(dplyr)
#library()

default_data_dir <- 'Data/specdata'

getSensorData <- function(id, directory) {
    if (!dir.exists(directory)) {
        directory <- 'Data/specdata'
    } else {

    }
    fpath <-
        sprintf("%03d", id) %>%
        paste0(directory, '/', .,'.csv')
    data <- read.csv(fpath)
    return(data)
}

pollutantmean <- function(directory, pollutant, id = 1:332){
    pollutant_data <- vector()
    for (i in id) {
        sensor_data <- getSensorData(i, directory)
        if (pollutant == 'nitrate') {
            pollutant_data <- c(pollutant_data, sensor_data$nitrate)
        }
        if (pollutant == 'sulfate') {
            pollutant_data <- c(pollutant_data, sensor_data$sulfate)
        }
    }
    pollutant_mean <- mean(pollutant_data, na.rm = T)
    return(pollutant_mean)
}

complete <- function(directory, id = 1:332) {
    complete_df <- data.frame(id=id, nobs = NA)
    for (i in id) {
        sensor_data <- getSensorData(i, directory)
        complete_df$nobs[complete_df$id == i] <-
            sensor_data %>%
            subset(complete.cases(sensor_data$nitrate, sensor_data$sulfate)) %>%
            nrow()
    }
    return(complete_df)
}

corr <- function(directory, threshold = 0) {
    id_n_complete <- complete(directory)
    ids_to_calc  <- id_n_complete$id[id_n_complete$nobs>threshold]

    cor_values <- numeric()
    for (i in ids_to_calc) {
        sensor_data <- getSensorData(i, directory)
        correlation <-
            sensor_data %>%
            subset(complete.cases(sensor_data$nitrate, sensor_data$sulfate)) %$%
            cor(nitrate, sulfate)
        cor_values <- c(cor_values, correlation)
    }
    return(cor_values)
}
