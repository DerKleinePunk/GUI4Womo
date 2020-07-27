# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
SET(CORE_SYSTEM_NAME rbpi)
# Raspberry 2
SET(CPU cortex-a7)
SET(ARCH arm)
SET(ENABLE_NEON TRUE)
SET(OS "linux")
#set(CMAKE_C_FLAGS "-mcpu=cortex-a53 -mfpu=neon-vfpv4 -mfloat-abi=hard ${COMMON_FLAGS}" CACHE STRING "Flags for Raspberry PI 3")
SET(CMAKE_C_FLAGS "-mcpu=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard")
# I don't like -Wno-psabi but i found no other solution you see nothing with Warings on
SET(CMAKE_CXX_FLAGS "-mcpu=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -Wno-psabi")
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)
# SET(SYSROOT /home/punky/x-tools/arm-rpi-linux-gnueabihf/arm-rpi-linux-gnueabihf/sysroot)
SET(RPIROOT /home/punky/x-tools/rpiroot)
# specify the cross compiler
# SET(CMAKE_C_COMPILER arm-linux-gnueabihf-gcc-8)
#SET(CMAKE_CXX_COMPILER /home/punky/x-tools/armv7-rpi2-linux-gnueabihf/bin/armv7-rpi2-linux-gnueabihf-g++)
#SET(CMAKE_C_COMPILER /home/punky/x-tools/arm-rpi-linux-gnueabihf/bin/arm-rpi-linux-gnueabihf-gcc)
#SET(CMAKE_CXX_COMPILER /home/punky/x-tools/arm-rpi-linux-gnueabihf/bin/arm-rpi-linux-gnueabihf-g++)
#SET(CMAKE_AR /home/punky/x-tools/arm-rpi-linux-gnueabihf/bin/arm-rpi-linux-gnueabihf-ar)
SET(CMAKE_FIND_ROOT_PATH ${RPIROOT})
SET(CMAKE_SYSROOT ${RPIROOT})
# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
#SET(GCC_COVERAGE_LINK_FLAGS "-v")
#SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${GCC_COVERAGE_LINK_FLAGS}" )
SET(ENV{PKG_CONFIG_DIR} "")
SET(ENV{PKG_CONFIG_LIBDIR} "${CMAKE_SYSROOT}/usr/lib/pkgconfig:${CMAKE_SYSROOT}/usr/share/pkgconfig:${CMAKE_SYSROOT}/usr/lib/arm-linux-gnueabihf/pkgconfig")
SET(ENV{PKG_CONFIG_SYSROOT_DIR} ${CMAKE_SYSROOT})