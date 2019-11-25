# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME xenia-core)
set(SUB_PATH xenia)

file(GLOB ${NAME}_SOURCES CONFIGURATION_DEPENDS
  ${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/*.h
  ${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/*.cc)
add_library(${NAME} ${LIBRARY_TYPE} ${${NAME}_SOURCES})
target_include_directories(${NAME} PRIVATE $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia/third_party>)
target_link_libraries(${NAME}
  PRIVATE
    xenia-base
    xenia-kernel
    xenia-gpu
)
set_target_properties(${NAME} PROPERTIES FOLDER "xenia")
