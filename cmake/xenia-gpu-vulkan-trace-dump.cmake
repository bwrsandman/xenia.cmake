# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME xenia-gpu-vulkan-trace-dump)
set(SUB_PATH xenia/gpu/vulkan)

list(APPEND ${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/vulkan_trace_dump_main.cc")
list(APPEND ${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/xenia/base/main${PLATFORM_SUFFIX}.cc")

add_library(${NAME} ${LIBRARY_TYPE} ${${NAME}_SOURCES})
target_include_directories(${NAME}
  PRIVATE
    $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}>
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia>
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia/src>)
target_link_libraries(${NAME}
  PRIVATE
    xenia-apu-nop
    xenia-cpu-backend-x64
    xenia-gpu-vulkan
    xenia-hid-nop
    xenia-kernel
)
