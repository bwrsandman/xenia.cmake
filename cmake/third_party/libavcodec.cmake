# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME libavcodec)
set(SUB_PATH xenia/third_party/libav)

if (TARGET ${NAME})
    message("${NAME} target already found, skipping to save time")
    return()
endif ()

file(GLOB ${NAME}_SOURCES CONFIGURE_DEPENDS
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/**/fdct.*"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/**/fdctdsp_init*.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/**/fft.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/**/fft_init*.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/avfft.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/avpacket.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/bitstream.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/bitstream_filter.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/codec_desc.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/fft_float.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/get_bits.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/imgconvert.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/log2_tab.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/mathtables.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/mdct_float.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/options.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/parser.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/put_bits.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/pthread.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/pthread_*"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/qsv_api.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/sinewin.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/utils.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/wmaprodata.h"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/wma.*"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/wma_common.*"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/wma_freqs.*"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/xma2dec.c"
  "${CMAKE_SOURCE_DIR}/${SUB_PATH}/${NAME}/xma2dec.h")

add_library(${NAME} ${LIBRARY_TYPE} ${${NAME}_SOURCES})
target_include_directories(${NAME} PUBLIC
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/${SUB_PATH}>)
target_link_libraries(${NAME} PRIVATE libavutil)
if (MSVC)
    target_compile_options(${NAME} PRIVATE
      /wd4013  # undefined; assuming extern returning int
      /wd4018  # signed/unsigned mismatch
      /wd4028  # formal parameter 3 different from declaration
      /wd4047  # 'initializing': 'x' differs in levels of indirection from 'x'
      /wd4087
      /wd4089  # different types in actual parameter x, formal parameter x
      /wd4090  # different const qualifiers
      /wd4101  # unreferenced local variable
      /wd4113
      /wd4133  # incompatible types
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
