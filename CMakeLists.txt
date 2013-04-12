cmake_minimum_required(VERSION 2.6)
project(globalsearch)

############################## required libraries
find_package        ( Boost REQUIRED date_time )
include_directories ( SYSTEM ${Boost_INCLUDE_DIRS} )

############################## compiling
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

############################## packaging
#install ( TARGETS globalsearch RUNTIME DESTINATION bin )
#install ( FILES ${ICE_FILE} ${BED_FILE}
#          DESTINATION /usr/share/globalsearch
#          PERMISSIONS WORLD_READ )