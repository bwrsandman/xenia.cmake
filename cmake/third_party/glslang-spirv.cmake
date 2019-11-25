# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME glslang-spirv)
set(SUB_PATH xenia/third_party)

if (TARGET ${NAME})
    message("${NAME} target already found, skipping to save time")
    return()
endif ()

set(${NAME}_SOURCES
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/bitutils.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/disassemble.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/disassemble.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/doc.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/doc.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/GLSL.ext.AMD.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/GLSL.ext.EXT.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/GLSL.ext.KHR.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/GLSL.ext.NV.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/GLSL.std.450.h"
  # Disabled until required.
  # "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/GlslangToSpv.cpp"
  # "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/GlslangToSpv.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/hex_float.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/InReadableOrder.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/Logger.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/Logger.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/spirv.hpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/SpvBuilder.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/SpvBuilder.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/spvIR.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/SPVRemapper.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/SPVRemapper.h")

add_library(${NAME} ${LIBRARY_TYPE} ${${NAME}_SOURCES})
target_include_directories(${NAME} PUBLIC
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/${${SUB_PATH}}/${NAME}>)
set_target_properties(${NAME} PROPERTIES FOLDER "${SUB_PATH}")
