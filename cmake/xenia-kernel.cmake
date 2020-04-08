# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME xenia-kernel)
set(SUB_PATH xenia/kernel)

match_platform_files(${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}" "*")
match_platform_files(${NAME}_UTIL_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/util" "*")
match_platform_files(${NAME}_XAM_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/xam" "*")
match_platform_files(${NAME}_XAM_APPS_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/xam/apps" "*")
match_platform_files(${NAME}_XBDM_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/xbdm" "*")
match_platform_files(${NAME}_XBOXKRNL_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/xboxkrnl" "*")
add_library(${NAME} ${LIBRARY_TYPE}
  ${${NAME}_SOURCES}
  ${${NAME}_UTIL_SOURCES}
  ${${NAME}_XAM_SOURCES}
  ${${NAME}_XAM_APPS_SOURCES}
  ${${NAME}_XBDM_SOURCES}
  ${${NAME}_XBOXKRNL_SOURCES})
target_include_directories(${NAME}
  PRIVATE
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia/src>
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia>)
target_link_libraries(${NAME}
  PRIVATE
    fmt
    imgui
    aes_128
    xenia-apu
    xenia-cpu
    xenia-hid
    xenia-ui
    xenia-vfs)
set_target_properties(${NAME} PROPERTIES FOLDER "xenia")
