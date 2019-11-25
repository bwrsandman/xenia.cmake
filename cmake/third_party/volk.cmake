# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME volk)
set(SUB_PATH xenia/third_party)

if (TARGET ${NAME})
    message("${NAME} target already found, skipping to save time")
    return()
endif ()

set(${NAME}_SOURCES
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/volk.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/volk.c")

add_library(${NAME} ${LIBRARY_TYPE} ${${NAME}_SOURCES})
target_include_directories(${NAME} PUBLIC
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}>)
target_compile_definitions(${NAME} PRIVATE "API_NAME=\"vulkan\"")
if (WIN32)
    target_compile_definitions(${NAME} PRIVATE VK_USE_PLATFORM_WIN32_KHR)
elseif(UNIX)
    target_compile_definitions(${NAME} PRIVATE VK_USE_PLATFORM_XCB_KHR)
    target_link_libraries(${NAME} PRIVATE dl)
endif()
set_target_properties(${NAME} PROPERTIES FOLDER "${SUB_PATH}")
