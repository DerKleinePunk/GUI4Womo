# - Try to find GLIB2
# Once done, this will define
#
#  GLIB2_FOUND - system has GLIB2
#  GLIB2_INCLUDE_DIRS - the GLIB2 include directories
#  GLIB2_LIBRARIES - link these to use GLIB2
#
FIND_PACKAGE(PkgConfig)
PKG_CHECK_MODULES(PC_GLIB2 QUIET glib-2.0)

FIND_PATH(GLIB_INCLUDE_DIR
    NAMES glib.h
    HINTS ${PC_GLIB2_INCLUDEDIR}
          ${PC_GLIB2_INCLUDE_DIRS}
          $ENV{GLIB2_HOME}/include
          $ENV{GLIB2_ROOT}/include
          /usr/local/include
          /usr/include
          /glib2/include
          /glib-2.0/include
    PATH_SUFFIXES glib2 glib-2.0 glib-2.0/include
)
SET(GLIB_INCLUDE_DIRS ${GLIB_INCLUDE_DIR})

FIND_LIBRARY(GLIB_LIBRARIES
    NAMES glib2 glib-2.0
    HINTS ${PC_GLIB2_LIBDIR}
          ${PC_GLIB2_LIBRARY_DIRS}
          $ENV{GLIB2_HOME}/lib
          $ENV{GLIB2_ROOT}/lib
          /usr/local/lib
          /usr/lib
          /lib
          /glib-2.0/lib
    PATH_SUFFIXES glib2 glib-2.0
)

GET_FILENAME_COMPONENT(glib2LibDir "${GLIB_LIBRARIES}" PATH)
FIND_PATH(GLIB_CONFIG_INCLUDE_DIR
    NAMES glibconfig.h
    HINTS ${PC_GLIB2_INCLUDEDIR}
          ${PC_GLIB2_INCLUDE_DIRS}
          $ENV{GLIB2_HOME}/include
          $ENV{GLIB2_ROOT}/include
          /usr/local/include
          /usr/include
          /glib2/include
          /glib-2.0/include
          ${glib2LibDir}
          ${CMAKE_SYSTEM_LIBRARY_PATH}
    PATH_SUFFIXES glib2 glib-2.0 glib-2.0/include
)
IF(GLIB_CONFIG_INCLUDE_DIR)
    SET(GLIB_INCLUDE_DIRS ${GLIB_INCLUDE_DIRS} ${GLIB_CONFIG_INCLUDE_DIR})
ENDIF()

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Glib DEFAULT_MSG GLIB_INCLUDE_DIRS GLIB_LIBRARIES)
MARK_AS_ADVANCED(GLIB_INCLUDE_DIR GLIB_CONFIG_INCLUDE_DIR)
