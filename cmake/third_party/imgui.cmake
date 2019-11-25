# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME imgui)
set(SUB_PATH xenia/third_party)

if (TARGET ${NAME})
    message("${NAME} target already found, skipping to save time")
    return()
endif ()

set(${NAME}_SOURCES
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/imconfig.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/imgui.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/imgui.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/imgui_draw.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/imgui_demo.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/imgui_internal.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/imgui_widgets.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/imstb_rectpack.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/imstb_textedit.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/imstb_truetype.h")

add_library(${NAME} ${LIBRARY_TYPE} ${${NAME}_SOURCES})
target_include_directories(${NAME} PUBLIC
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}>)
set_target_properties(${NAME} PROPERTIES FOLDER "${SUB_PATH}")
