# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME capstone)
set(SUB_PATH xenia/third_party)

if (TARGET ${NAME})
    message("${NAME} target already found, skipping to save time")
    return()
endif ()

file(GLOB ${NAME}_SOURCES CONFIGURE_DEPENDS
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/cs.c
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/cs_priv.h
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/LEB128.h
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/MathExtras.h
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/MCDisassembler.h
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/MCFixedLenDisassembler.h
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/MCInst.c
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/MCInst.h
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/MCInstrDesc.c
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/MCInstrDesc.h
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/MCRegisterInfo.c
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/MCRegisterInfo.h
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/SStream.c
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/SStream.h
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/utils.c
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/utils.h
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/arch/X86/*.c
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/arch/X86/*.h
  ${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/arch/X86/*.inc)
message(${${NAME}_SOURCES})
add_library(${NAME} ${LIBRARY_TYPE} ${${NAME}_SOURCES})

target_compile_definitions(${NAME}
  PRIVATE
    CAPSTONE_X86_ATT_DISABLE
    CAPSTONE_DIET_NO
    CAPSTONE_X86_REDUCE_NO
    CAPSTONE_HAS_X86
    CAPSTONE_USE_SYS_DYN_MEM)

target_include_directories(${NAME} PUBLIC
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/include>)
if (MSVC)
else()
    target_compile_options(${NAME} PRIVATE
      -Wno-error=write-strings
      -Wno-write-string
      -Wno-deprecated
      -w)
endif()

#include(ExternalProject)
#ExternalProject_Add(${NAME}
#  SOURCE_DIR ${CMAKE_SOURCE_DIR}/xenia/third_party/${NAME}
#  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/install/${NAME})
set_target_properties(${NAME} PROPERTIES
  FOLDER "${SUB_PATH}"
  LINKER_LANGUAGE C)
