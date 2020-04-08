# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME fmt)
set(SUB_PATH xenia/third_party)

if (TARGET ${NAME})
    message("${NAME} target already found, skipping to save time")
    return()
endif ()

file(GLOB ${NAME}_SOURCES CONFIGURE_DEPENDS
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/include/fmt/chrono.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/include/fmt/color.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/include/fmt/compile.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/include/fmt/core.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/include/fmt/format.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/include/fmt/format-inl.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/include/fmt/locale.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/include/fmt/os.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/include/fmt/ostream.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/include/fmt/posix.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/include/fmt/printf.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/include/fmt/ranges.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/src/format.cc"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/src/os.cc")

add_library(${NAME} ${LIBRARY_TYPE} ${${NAME}_SOURCES})
target_include_directories(${NAME} PUBLIC
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}>)
set_target_properties(${NAME} PROPERTIES FOLDER "${SUB_PATH}")