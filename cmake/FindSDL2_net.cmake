# Locate SDL_net library
#
# This module defines:
#
# ::
#
#   SDL_NET_LIBRARIES, the name of the library to link against
#   SDL_NET_INCLUDE_DIRS, where to find the headers
#   SDL_NET_FOUND, if false, do not try to link against
#   SDL_NET_VERSION_STRING - human-readable string containing the version of SDL_net
#
#
#
# For backward compatiblity the following variables are also set:
#
# ::
#
#   SDLNET_LIBRARY (same value as SDL_NET_LIBRARIES)
#   SDLNET_INCLUDE_DIR (same value as SDL_NET_INCLUDE_DIRS)
#   SDLNET_FOUND (same value as SDL_NET_FOUND)
#
#
#
# $SDLDIR is an environment variable that would correspond to the
# ./configure --prefix=$SDLDIR used in building SDL.
#
# Created by Eric Wing.  This was influenced by the FindSDL.cmake
# module, but with modifications to recognize OS X frameworks and
# additional Unix paths (FreeBSD, etc).

#=============================================================================
# Copyright 2005-2009 Kitware, Inc.
# Copyright 2012 Benjamin Eikel
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of CMake, substitute the full
#  License text for the above reference.)

SET(SDL2_SEARCH_PATHS
    ${SDL2_SRC}
	~/Library/Frameworks
	/Library/Frameworks
	/usr/local
	/usr
	/sw # Fink
	/opt/local # DarwinPorts
	/opt/csw # Blastwave
	/opt
	${SDL2_PATH}
)

if(CMAKE_SIZEOF_VOID_P EQUAL 8) 
    if(MINGW AND WIN32)
		set(SDL2_PATH_SUFFIXES x86_64-w64-mingw32/include/SDL2 x86_64-w64-mingw32/include)
	endif()
else() 
    if(MINGW AND WIN32)
		set(SDL2_PATH_SUFFIXES i686-w64-mingw32/include/SDL2 i686-w64-mingw32/include)
	endif()
endif() 

find_path(SDL2_NET_INCLUDE_DIR SDL_net.h
        HINTS
        ENV SDL2NETDIR
        ENV SDL2DIR
        PATH_SUFFIXES SDL2 ${SDL2_PATH_SUFFIXES}
        # path suffixes to search inside ENV{SDLDIR}
        include/SDL2 include
        PATHS ${SDL2_SEARCH_PATHS}
        )

if(CMAKE_SIZEOF_VOID_P EQUAL 8) 
	set(PATH_SUFFIXES lib64 lib/x64 lib)
    if(MINGW)
		set(PATH_SUFFIXES ${PATH_SUFFIXES} x86_64-w64-mingw32/lib)
	endif()
else() 
	set(PATH_SUFFIXES lib/x86 lib)
    if(MINGW)
		set(PATH_SUFFIXES ${PATH_SUFFIXES} i686-w64-mingw32/lib)
	endif()
endif() 

MESSAGE(STATUS "search for PATH_SUFFIX in ${PATH_SUFFIXES}")

find_library(SDL2_NET_LIBRARY
        NAMES SDL2_net
        HINTS
        $ENV{SDL2NETDIR}
        $ENV{SDL2DIR}
        PATH_SUFFIXES ${PATH_SUFFIXES}
        PATHS ${SDL2_SEARCH_PATHS}
        )

MESSAGE(STATUS "search for PATH_SUFFIX in ${SDL2_NET_LIBRARY}")

if(SDL2_IMAGE_INCLUDE_DIR AND EXISTS "${SDL2_NET_INCLUDE_DIR}/SDL_net.h")
    file(STRINGS "${SDL2_NET_INCLUDE_DIR}/SDL_net.h" SDL2_NET_VERSION_MAJOR_LINE REGEX "^#define[ \t]+SDL_NET_MAJOR_VERSION[ \t]+[0-9]+$")
    file(STRINGS "${SDL2_NET_INCLUDE_DIR}/SDL_net.h" SDL2_NET_VERSION_MINOR_LINE REGEX "^#define[ \t]+SDL_NET_MINOR_VERSION[ \t]+[0-9]+$")
    file(STRINGS "${SDL2_NET_INCLUDE_DIR}/SDL_net.h" SDL2_NET_VERSION_PATCH_LINE REGEX "^#define[ \t]+SDL_NET_PATCHLEVEL[ \t]+[0-9]+$")
    string(REGEX REPLACE "^#define[ \t]+SDL_NET_MAJOR_VERSION[ \t]+([0-9]+)$" "\\1" SDL2_NET_VERSION_MAJOR "${SDL2_NET_VERSION_MAJOR_LINE}")
    string(REGEX REPLACE "^#define[ \t]+SDL_NET_MINOR_VERSION[ \t]+([0-9]+)$" "\\1" SDL2_NET_VERSION_MINOR "${SDL2_NET_VERSION_MINOR_LINE}")
    string(REGEX REPLACE "^#define[ \t]+SDL_NET_PATCHLEVEL[ \t]+([0-9]+)$" "\\1" SDL2_NET_VERSION_PATCH "${SDL2_NET_VERSION_PATCH_LINE}")
    set(SDL2_NET_VERSION_STRING ${SDL2_NET_VERSION_MAJOR}.${SDL2_NET_VERSION_MINOR}.${SDL2_NET_VERSION_PATCH})
    unset(SDL2_NET_VERSION_MAJOR_LINE)
    unset(SDL2_NET_VERSION_MINOR_LINE)
    unset(SDL2_NET_VERSION_PATCH_LINE)
    unset(SDL2_NET_VERSION_MAJOR)
    unset(SDL2_NET_VERSION_MINOR)
    unset(SDL2_NET_VERSION_PATCH)
endif()

set(SDL2_NET_LIBRARIES ${SDL2_NET_LIBRARY})
set(SDL2_NET_INCLUDE_DIRS ${SDL2_NET_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)

FIND_PACKAGE_HANDLE_STANDARD_ARGS(SDL2_net
        REQUIRED_VARS SDL2_NET_LIBRARIES SDL2_NET_INCLUDE_DIRS
        VERSION_VAR SDL2_NET_VERSION_STRING)

# for backward compatiblity
#set(SDLIMAGE_LIBRARY ${SDL_IMAGE_LIBRARIES})
#set(SDLIMAGE_INCLUDE_DIR ${SDL_IMAGE_INCLUDE_DIRS})
#set(SDLIMAGE_FOUND ${SDL_IMAGE_FOUND})

mark_as_advanced(SDL2_NET_LIBRARY SDL2_NET_INCLUDE_DIR)

