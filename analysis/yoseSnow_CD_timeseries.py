
import rasterio
import numpy as np

# Load a stack of MODIS images
yoseSnow_stack = []
for i in range(23):
    with rasterio.open(f'D:\Emma_C\projects\yosemiteSnow\data\data_GEE\Snow_Cover_{i}.tif') as src:
        yoseSnow_stack.append(src.read())

# Convert the list to a numpy array
yoseSnow_stack = np.array(yoseSnow_stack)

# Calculate mean and variance for each pixel over time
mean = np.mean(yoseSnow_stack, axis=0)
variance = np.var(yoseSnow_stack, axis=0)