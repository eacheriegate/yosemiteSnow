import rasterio
import numpy as np

# Open the datasets
with rasterio.open('D:\Emma_C\projects\yosemiteSnow\data\data_GEE\Snow_Cover_2000.tif') as src:
    yoseSnow_2000 = src.read()

with rasterio.open('D:\Emma_C\projects\yosemiteSnow\data\data_GEE\Snow_Cover_2023.tif') as src:
    yoseSnow_2023 = src.read()
    
# Compute difference
difference = np.abs(yoseSnow_2000 - yoseSnow_2023)

# Any non-zero values in 'difference' indicate change
change_map = np.where(difference > 0, 1, 0)