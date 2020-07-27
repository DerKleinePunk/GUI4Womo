message(STATUS "working on utils dir")

FILE (GLOB_RECURSE SRCS "LogNetDispatcher.cpp" "UdpLogClient.cpp" "CommandLineArgs.cpp" )

set(common_utils_SRCS ${SRCS} PARENT_SCOPE)

