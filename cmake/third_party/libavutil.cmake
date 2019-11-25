# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME libavutil)
set(SUB_PATH xenia/third_party/libav)

if (TARGET ${NAME})
    message("${NAME} target already found, skipping to save time")
    return()
endif ()

file(GLOB ${NAME}_SOURCES CONFIGURE_DEPENDS
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/*.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/*.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/x86/*.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/x86/*.h")

add_library(${NAME} ${LIBRARY_TYPE} ${${NAME}_SOURCES})
target_include_directories(${NAME} PUBLIC
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/${SUB_PATH}>)
if (MSVC)
    target_compile_options(${NAME} PRIVATE
      /wd4018  # signed/unsigned mismatch
      /wd4028  # formal parameter 3 different from declaration
      /wd4090  # different const qualifiers
      /wd4101  # unreferenced local variable
      /wd4146  # unary minus operator applied to unsigned type, result still unsigned
      /wd4244  # conversion 'x' to 'x', possible loss of data
      /wd4267  # 'initializing': conversion from 'x' to 'x', possible loss of data
      /wd4305  # 'initializing': truncation from 'x' to 'x'
    )
else()
    if (CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        target_compile_options(${NAME} PRIVATE
          -Wno-error=incompatible-pointer-types-discards-qualifiers
          -Wno-error=switch
          -Wno-error=incompatible-pointer-types
          -Wno-error=logical-op-parentheses
          -Wno-error=pointer-sign
          -Wno-error=parentheses
        )
    elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        target_compile_options(${NAME} PRIVATE
          -Wno-error=switch
          -Wno-error=incompatible-pointer-types
          -Wno-error=pointer-sign
          -Wno-error=parentheses
          )
    endif()
endif()
set_target_properties(${NAME} PROPERTIES FOLDER "${SUB_PATH}")
