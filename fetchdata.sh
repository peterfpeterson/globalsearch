#!/bin/sh
BASE_URL=http://www.ngdc.noaa.gov/mgg/global/relief/ETOPO1/data

echo "downloading ice data"
wget -c $BASE_URL/ice_surface/grid_registered/netcdf/ETOPO1_Ice_g_gdal.grd.gz
echo "downloading bedrock data"
wget -c $BASE_URL/bedrock/grid_registered/netcdf/ETOPO1_Bed_g_gdal.grd.gz
