# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME xenia-vfs-dump)
set(SUB_PATH xenia/vfs)

list(APPEND ${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/vfs_dump.cc")
list(APPEND ${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/xenia/base/main${PLATFORM_SUFFIX}.cc")

add_library(${NAME} ${LIBRARY_TYPE} ${${NAME}_SOURCES})
target_include_directories(${NAME}
  PRIVATE
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia/third_party>
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia/src>)
target_link_libraries(${NAME} PRIVATE xenia-vfs)
