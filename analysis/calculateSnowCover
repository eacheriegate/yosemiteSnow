///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////// This script calculates  changes in snow cover from December to March using TERRA MODIS data spanning from 2000 to 2023. /////// 
///////   It generates two outputs: a CSV detailing the snow-covered area for each year and a raster TIFF file for each year.   ///////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Import yosemite national park shapefile and add to map // 
// shapefile source: (https://catalog.data.gov/dataset/yosemite-national-park-tract-and-boundary-data-c453b)

// Center map on yosemite boundary
Map.centerObject(yosemitePark, 8);
var outline = {fillColor: '00000000', width: 2.0};
Map.addLayer(yosemitePark.style(outline), {}, 'yosemitePark');

// Calculate Yosemite's total area in square kilometers
var yosemiteArea = ee.Image.pixelArea().reduceRegion({
  reducer: ee.Reducer.sum(),
  geometry: yosemitePark,
  scale: 500,
  maxPixels: 1e13
}).getNumber('area').divide(1e6).round(); // Convert to km^2

/////////////////////////////////////////////////////
/////////////// Calculate Snow Cover //////////////// 
/////////////////////////////////////////////////////

// Define the time range and initialize an empty list to hold yearly data
var startYear = 2000;
var endYear = 2023;
var features = ee.List([]);

// Iterate over each year and filter data for the winter months
for (var year = startYear; year <= endYear; year++) {
  var startDate = ee.Date.fromYMD(year, 12, 1);
  var endDate = ee.Date.fromYMD(year + 1, 3, 31);
  
  var modisData = ee.ImageCollection("MODIS/061/MOD10A1")
                    .filterDate(startDate, endDate)
                    .select('NDSI_Snow_Cover');

// Calculate the mean snow cover for the winter season
  var meanSnow = modisData.mean().clip(yosemitePark);

// Visualization parameters
  var visParams = {
    min: 0,
    max: 100,
    palette: ['white', 'cyan', 'blue', 'purple']
 };

// Add the mean snow cover image to the map with a year label
  Map.addLayer(meanSnow, visParams, 'Snow Cover ' + year, true);

// Assign visual parameters to TIFF for export  
var visSnow = meanSnow.visualize({
  min: 0,
  max: 100,
  palette: ['white', 'cyan', 'blue', 'purple']
});

// Export the image for each year
  Export.image.toDrive({
    image: visSnow,
    description: 'SnowCover_' + year,
    folder: 'yoseSnow_geeData',
    fileNamePrefix: 'Snow_Cover_' + year,
    scale: 500,
    region: yosemitePark,
    fileFormat: 'GeoTIFF'
  });

// Calculate snow cover area in square kilometers
  var snowCoverArea = meanSnow
                   .multiply(ee.Image.pixelArea())
                   .reduceRegion({
                     reducer: ee.Reducer.sum(),
                     geometry: yosemitePark,
                     scale: 500,
                     maxPixels: 1e9
                   }).getNumber('NDSI_Snow_Cover').divide(1e6).round(); // Convert to km^2

  // Create a feature for each year with snow cover and total area
  var areaData = ee.Feature(null, {
    'Year': year,
    'Total_Area_km2': yosemiteArea,
    'Snow_Cover_Area_km2': snowCoverArea
  }); 

  // Append the feature to the list
  features = features.add(areaData);
}

// Convert list of features to a FeatureCollection
var snowCollection = ee.FeatureCollection(features);

// Export the feature to Drive as CSV
  Export.table.toDrive({
    collection: snowCollection,
    description: 'yose_snowCover_timeseries',
    folder: 'yoseSnow_geeData',
    fileNamePrefix: 'yose_snowCover_timeseries',
    fileFormat: 'CSV'
  });
