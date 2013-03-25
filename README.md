globalsearch
============

A comparison of optimization by searching for highest point in the world.

Data
====

This program works by reading the netCDF files from [NOAA](http://www.ngdc.noaa.gov/mgg/global/global.html) and searching for the highest point in the data using various optimization algorithms.

Requirements
============
This is written in C++ and built using CMake. CMake will point out the missing requirements, but nominally:
 * C++ compiler
 * CMake
 * HDF5

Algorithms
==========
globalsearch is meant to be an implementation of serveral different optimization methods. See the code for which ones are implemented.
