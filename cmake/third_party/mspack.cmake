# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME mspack)
set(SUB_PATH xenia/third_party)

if (TARGET ${NAME})
    message("${NAME} target already found, skipping to save time")
    return()
endif ()

set(${NAME}_SOURCES
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/logging.cc"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/lzx.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/lzxd.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/mspack.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/readbits.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/readhuff.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/system.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/system.h")

add_library(${NAME} ${LIBRARY_TYPE} ${${NAME}_SOURCES})
target_include_directories(${NAME} PUBLIC
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}>)
target_link_libraries(${NAME} PRIVATE xenia-base)
target_compile_definitions(${NAME} PRIVATE HAVE_CONFIG_H)
set_target_properties(${NAME} PROPERTIES FOLDER "${SUB_PATH}")
