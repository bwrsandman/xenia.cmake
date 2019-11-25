# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME cpptoml)
set(SUB_PATH xenia/third_party)

if (TARGET ${NAME})
    message("${NAME} target already found, skipping to save time")
    return()
endif ()

set(${NAME}_SOURCES
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/include/cpptoml.h")

add_library(${NAME} ${LIBRARY_TYPE} ${${NAME}_SOURCES})
target_include_directories(${NAME} PUBLIC
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}>)
set_target_properties(${NAME} PROPERTIES
  FOLDER "${SUB_PATH}"
  LINKER_LANGUAGE CXX)

#include(FetchContent)

#FetchContent_Declare(${NAME} SOURCE_DIR ${CMAKE_SOURCE_DIR}/xenia/third_party/${NAME})
#set(ENABLE_LIBCXX OFF CACHE BOOL "" FORCE)
#set(CPPTOML_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
#FetchContent_MakeAvailable(${NAME})
#set_target_properties(${NAME} PROPERTIES FOLDER "${SUB_PATH}")
