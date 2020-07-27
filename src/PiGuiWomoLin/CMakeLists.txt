project("PiGuiWomoLin" CXX)

INCLUDE_DIRECTORIES(${SDL2_INCLUDE_DIRS})
INCLUDE_DIRECTORIES(${SDL2_NET_INCLUDE_DIRS})
INCLUDE_DIRECTORIES(${CURL_INCLUDE_DIR})
INCLUDE_DIRECTORIES(${MAINFOLDER}/src/PiGuiWomoLin)

MESSAGE(STATUS "Try Build ${PROJECT_NAME}")

## Use all the *.cpp files we found under this folder for the project Find better way for coomen cpp files
FILE(GLOB SRCS "*.cpp" "*/*.cpp")

if(${CMAKE_SYSTEM_NAME} STREQUAL "Windows" )
    SET (project_BIN ${PROJECT_NAME})
else()
    SET (project_BIN ${PROJECT_NAME}.bin)
endif()

add_executable(${project_BIN} ${SRCS} ${common_utils_SRCS} ${GUI_SRCS} ${MAIN_common_SRCS} ${SOUND_MINI_SRCS})

TARGET_LINK_LIBRARIES(${project_BIN} ${SDL2_LIBRARIES} ${SDL2_IMAGE_LIBRARIES} ${SDL2_TTF_LIBRARIES})
TARGET_LINK_LIBRARIES(${project_BIN} ${SDL2_NET_LIBRARIES})

IF(${SDL2_MIXER_FOUND})
    TARGET_LINK_LIBRARIES(${project_BIN} ${SDL2_MIXER_LIBRARIES})
    SET ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DENABLEAUDIOMANAGER") 
ENDIF()

IF("${TARGET}" STREQUAL "PI")
    # Why i need this ?!?
    TARGET_LINK_LIBRARIES(${project_BIN} ${RPIROOT}/opt/vc/lib/libmmal_core.so)
    TARGET_LINK_LIBRARIES(${project_BIN} ${RPIROOT}/opt/vc/lib/libmmal_util.so)
    TARGET_LINK_LIBRARIES(${project_BIN} ${RPIROOT}/opt/vc/lib/libmmal_vc_client.so)
    TARGET_LINK_LIBRARIES(${project_BIN} ${RPIROOT}/opt/vc/lib/libvcos.so)
    TARGET_LINK_LIBRARIES(${project_BIN} ${RPIROOT}/opt/vc/lib/libvchiq_arm.so)
    TARGET_LINK_LIBRARIES(${project_BIN} ${RPIROOT}/opt/vc/lib/libvcsm.so)
ENDIF()

SET(directory "${EXECUTABLE_OUTPUT_PATH}/data")
FILE(MAKE_DIRECTORY ${directory})
MESSAGE(STATUS "will create ${directory}")
add_custom_target(MAKEDATA ${project_BIN} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E make_directory ${directory})

SET(directory "${EXECUTABLE_OUTPUT_PATH}/logs")
FILE(MAKE_DIRECTORY ${directory})
MESSAGE(STATUS "will create ${directory}")
add_custom_target(MAKELOGS ${project_BIN} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E make_directory ${directory})

set(MAINFONTSOURCE "${MAINFOLDER}/src/logger.conf")
add_custom_command(TARGET ${project_BIN} POST_BUILD # Adds a post-build event to MyTest
                    COMMAND ${CMAKE_COMMAND} -E copy_if_different  # which executes "cmake - E copy_if_different..."
                       "${MAINFONTSOURCE}"      # <--this is in-file
                       $<TARGET_FILE_DIR:${project_BIN}>)