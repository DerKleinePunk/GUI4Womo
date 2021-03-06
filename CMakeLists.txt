cmake_minimum_required(VERSION 3.10 FATAL_ERROR)
# Main CMake

#
# Debugging Options
#
if (CMAKE_BUILD_TYPE STREQUAL "Debug") 
    SET (CMAKE_VERBOSE_MAKEFILE 1) # Use 1 for debugging, 0 for release
ENDIF()

#Build Cmake Environment
SET(PKG_CONFIG_USE_CMAKE_PREFIX_PATH TRUE)
find_package(PkgConfig)
include(CheckCXXCompilerFlag)
include(ExternalProject)
include(CheckTypeSize)

## Use the variable PROJECT_NAME for changing the target name
SET ( PROJECT_NAME "GUI-WomoLIN" )

## Version depens on
SET (SDL2_VER "2.0.12")
SET (SDL2_IMAGE_VER "2.0.1")
SET (SDL2_TTF_VER "2.0.12")

PROJECT(${PROJECT_NAME})

MESSAGE(STATUS "Try Build ${PROJECT_NAME}")
MESSAGE(STATUS "Compiler ${CMAKE_CXX_COMPILER_ID}")
MESSAGE(STATUS "Building on ${CMAKE_SYSTEM_NAME}")
MESSAGE(STATUS "Build for ${TARGET}")

#
# Project Output Paths
#
SET (MAINFOLDER ${PROJECT_SOURCE_DIR})
IF("${TARGET}" STREQUAL "")
   message(WARNING "TARGET not set please add -DTRAGET to command line Suported Target are Linux,PI (crosscompile)")
   SET(TARGET ${CMAKE_SYSTEM_NAME})
ENDIF()

IF("${CMAKE_EXPORT_COMPILE_COMMANDS}" STREQUAL "")
   SET(CMAKE_EXPORT_COMPILE_COMMANDS ON)
ENDIF()

SET (EXECUTABLE_OUTPUT_PATH "${MAINFOLDER}/bin/${TARGET}")
SET (LIBRARY_OUTPUT_PATH "${MAINFOLDER}/lib/${TARGET}")
SET (LIBS_DIR ${PROJECT_SOURCE_DIR}/libs/${TARGET})

MESSAGE(STATUS "Build to ${EXECUTABLE_OUTPUT_PATH}")

list(APPEND CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PROJECT_SOURCE_DIR}/cmake")

CHECK_CXX_COMPILER_FLAG("-std=c++17" COMPILER_SUPPORTS_CXX11)
IF(COMPILER_SUPPORTS_CXX11)
   SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++17")
ELSE()
   message(ERROR "we need c++17 to build")
ENDIF()

CHECK_INCLUDE_FILE_CXX("time.h" HAVE_TIME_H)
check_type_size("time_t" SIZEOF_TIME_T LANGUAGE CXX)

SET(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O0 -DDEBUG")
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DSIZEOF_TIME_T=${SIZEOF_TIME_T}")

IF(CMAKE_COMPILER_IS_GNUCXX)
  SET ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wno-psabi -DELPP_THREAD_SAFE -DELPP_FEATURE_PERFORMANCE_TRACKING -DELPP_NO_DEFAULT_LOG_FILE -DELPP_STACKTRACE_ON_CRASH")
  #-DELPP_STACKTRACE_ON_CRASH only on linux with gcc
ENDIF(CMAKE_COMPILER_IS_GNUCXX)

MESSAGE(STATUS "Compiler Flags are ${CMAKE_CXX_FLAGS}")

FIND_PACKAGE(SDL2 REQUIRED)
IF(NOT SDL2_FOUND)
    MESSAGE(FATAL_ERROR "we need sdl2")
ENDIF()

FIND_PACKAGE(SDL2_image REQUIRED)
FIND_PACKAGE(SDL2_ttf REQUIRED)
FIND_PACKAGE(SDL2_mixer)
FIND_PACKAGE(SDL2_net REQUIRED)

MESSAGE(STATUS "SDL2 ${SDL2_INCLUDE_DIRS} ${SDL2_IMAGE_INCLUDE_DIRS}")
ADD_SUBDIRECTORY(modules/SDL2GuiHelper/common)
ADD_SUBDIRECTORY(modules/SDL2GuiHelper/src)
ADD_SUBDIRECTORY(src)