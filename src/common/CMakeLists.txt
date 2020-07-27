message(STATUS "working on common dir")

ADD_SUBDIRECTORY(utils)

set(common_utils_SRCS ${common_utils_SRCS} PARENT_SCOPE)