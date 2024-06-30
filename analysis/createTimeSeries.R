library(dplyr)
library(ggplot2)

# Define directories
setwd("D:/Emma_C/projects/yosemiteSnow")
datadirectory = "D:/Emma_C/projects/yosemiteSnow/data"
GEEdirectory = "data_GEE"

################################################
######### Plot Snow Cover Time Series ##########
################################################

# Read GEE time series data
yoseSnowCoverData <- read.csv(file.path(datadirectory, GEEdirectory, "yose_snowCover_timeseries.csv"))

# Plot time series
yoseSnowCoverTimeSeries <- ggplot(data = yoseSnowCoverData, aes(x = Year, y = Snow_Cover_Area_km2)) +
  geom_point(size = 1, color = "#00FFFF") + 
  geom_line(color = "black", size = 2) +  # Black line slightly thicker as background
  geom_line(color = "#00FFFF", size = 1) +  
  theme_minimal() +
  labs(title = "Yosemite Snow Cover Area Time Series",
       x = "Year",
       y = "Snow Cover Area (km²)") +
  theme(legend.position = "none",  # Removing legend as it's unnecessary for a single variable plot
        panel.border = element_rect(color = "black", linewidth = 1, fill = NA),
        axis.title.x = element_text(margin = margin(t = 10)),
        axis.title.y = element_text(margin = margin(r = 10)))

# Visualize
yoseSnowCoverTimeSeries

ggsave("D:/Emma_C/projects/swi_gf/data/data_finalized/yoseSnowtimeseries.png", yoseSnowCoverTimeSeries, width = 9, height = 5, dpi = 800)

