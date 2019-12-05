# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME xenia-gpu)
set(SUB_PATH xenia/gpu)

match_platform_files(${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}" "*")
list(FILTER ${NAME}_SOURCES EXCLUDE REGEX ".*trace_viewer.cc$")
add_library(${NAME} ${LIBRARY_TYPE} ${${NAME}_SOURCES})
target_include_directories(${NAME}
  PRIVATE
    $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}>
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia/src>
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia>
  # Header leak from cpu/processor.h of cpptoml/include/cpptoml.h
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia/third_party>)
target_link_libraries(${NAME}
  PRIVATE
    dxbc
    glslang-spirv
    snappy
    spirv-tools
    xenia-ui-spirv
    xxhash)
set_target_properties(${NAME} PROPERTIES FOLDER "xenia")
