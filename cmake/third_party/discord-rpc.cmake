# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME discord-rpc)
set(SUB_PATH xenia/third_party)

if (TARGET ${NAME})
    message("${NAME} target already found, skipping to save time")
    return()
endif ()

file(GLOB ${NAME}_SOURCES CONFIGURE_DEPENDS
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/src/connection.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/src/discord_rpc.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/src/msg_queue.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/src/rpc_connection.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/src/rpc_connection.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/src/serialization.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/src/serialization.h")
if (WIN32)
    list(APPEND ${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/src/connection_win.cpp")
    list(APPEND ${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/src/discord_register_win.cpp")
elseif(APPLE)
    list(APPEND ${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/src/discord_register_osx.m")
elseif(UNIX)
    list(APPEND ${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/src/connection_unix.cpp")
    list(APPEND ${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/src/discord_register_linux.cpp")
endif()

add_library(${NAME} ${LIBRARY_TYPE} ${${NAME}_SOURCES})
target_include_directories(${NAME} PUBLIC
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/include>
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/${SUB_PATH}/rapidjson/include>)
set_target_properties(${NAME} PROPERTIES FOLDER "${SUB_PATH}")
