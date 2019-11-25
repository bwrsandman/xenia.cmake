# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME spirv-tools)
set(SUB_PATH xenia/third_party)

if (TARGET ${NAME})
    message("${NAME} target already found, skipping to save time")
    return()
endif ()

file(GLOB ${NAME}_SOURCES CONFIGURE_DEPENDS
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/include/spirv-tools/libspirv.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/val/basic_block.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/val/basic_block.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/val/construct.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/val/construct.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/val/function.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/val/function.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/val/validation_state.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/val/validation_state.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/util/*.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/util/*.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/val/*.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/val/*.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/*.inc"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/*.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/*.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/assembly_grammar.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/assembly_grammar.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/binary.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/binary.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/diagnostic.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/diagnostic.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/disassemble.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/ext_inst.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/ext_inst.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/instruction.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/macro.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/opcode.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/opcode.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/operand.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/operand.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/print.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/print.h"
  # "${CMAKE_SOURCE_DIR}/${SUB_PATH}ty/${NAME}/source/software_version.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/spirv_constant.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/spirv_definition.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/spirv_endian.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/spirv_endian.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/spirv_target_env.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/spirv_target_env.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/table.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/table.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/text.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/text.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/text_handler.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/text_handler.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/validate.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/validate.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/validate_cfg.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/validate_id.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/validate_instruction.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/validate_layout.cpp"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/util/bitutils.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source/util/hex_float.h"
  )

add_library(${NAME} ${LIBRARY_TYPE} ${${NAME}_SOURCES})
target_include_directories(${NAME} PUBLIC
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/${SUB_PATH}/spirv-headers/include>
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/include>
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/source>)
set_target_properties(${NAME} PROPERTIES FOLDER "${SUB_PATH}")
