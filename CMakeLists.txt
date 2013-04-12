cmake_minimum_required(VERSION 2.6)
project(globalsearch)

############################## required libraries
find_package        ( Boost REQUIRED date_time )
include_directories ( SYSTEM ${Boost_INCLUDE_DIRS} )

############################## get data
set (ICE_FILE "ETOPO1_Ice_g_gdal.grd")
set (BED_FILE "ETOPO1_Bed_g_gdal.grd")

# use wget to download the data files
find_program( WGET_EXE wget)
set (BASE_URL "http://www.ngdc.noaa.gov/mgg/global/relief/ETOPO1/data")
if (WGET_EXE)
  message ("Using wget (${WGET_EXE})")
  message ("Will download ${ICE_FILE}.gz approx 377MB")
  # download the ice data
  set (ICE_URL "${BASE_URL}/ice_surface/grid_registered/netcdf/${ICE_FILE}.gz")
  add_custom_command (
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${ICE_FILE}.gz
    COMMAND ${WGET_EXE} -c ${ICE_URL}
  )
#    COMMAND ${WGET_EXE} -o ${CMAKE_CURRENT_BINARY_DIR}/${ICE_FILE}.gz -c ${ICE_URL}

  # download the bedrock data
  set (BED_URL "${BASE_URL}/bedrock/grid_registered/netcdf/${BED_FILE}.gz")
  message ("Will download ${BED_FILE}.gz approx 384MB")
  add_custom_command (
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${BED_FILE}.gz
    COMMAND ${WGET_EXE} -c ${BED_URL}
  )
#    COMMAND ${WGET_EXE} -o ${CMAKE_CURRENT_BINARY_DIR}/${BED_FILE}.gz -c ${BED_URL}

else (WGET_EXE)
  message ("Failed to find wget.")
  message ("Download the netcdf data at ${BASE_URL}")
endif (WGET_EXE)

############################## unpack data
find_program( GUNZIP_EXE gunzip)
if (GUNZIP_EXE)
  add_custom_command (
    OUTPUT  ${CMAKE_CURRENT_BINARY_DIR}/${ICE_FILE}
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${ICE_FILE}.gz
    COMMAND ${GUNZIP_EXE} ${CMAKE_CURRENT_BINARY_DIR}/${ICE_FILE}.gz )
  add_custom_command (
    OUTPUT  ${CMAKE_CURRENT_BINARY_DIR}/${BED_FILE}
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${BED_FILE}.gz
    COMMAND ${GUNZIP_EXE} ${CMAKE_CURRENT_BINARY_DIR}/${BED_FILE}.gz )
else (GUNZIP_EXE)
  message (FATAL_ERROR "Failed to find the program 'gunzip'")
endif (GUNZIP_EXE)

add_custom_target ( data
  DEPENDS  ${CMAKE_CURRENT_BINARY_DIR}/${BED_FILE} ${CMAKE_CURRENT_BINARY_DIR}/${ICE_FILE} )



############################## unpack data
#Sends the -std=c99 flag to the gcc compiler
#add_definitions(-std=c++99)

set (SRC_FILES
  main.cpp
)

#This tells CMake to fib.c and name it fibonacci
add_executable(globalsearch ${SRC_FILES} )
#add_dependencies(globalsearch
#  ${CMAKE_CURRENT_BINARY_DIR}/${BED_FILE}.gz
#  ${CMAKE_CURRENT_BINARY_DIR}/${ICE_FILE}.gz
#)
target_link_libraries ( globalsearch ${Boost_LIBRARIES} )
#install ( TARGETS globalsearch RUNTIME DESTINATION bin )
#install ( FILES ${ICE_FILE} ${BED_FILE}
#          DESTINATION /usr/share/globalsearch
#          PERMISSIONS WORLD_READ )