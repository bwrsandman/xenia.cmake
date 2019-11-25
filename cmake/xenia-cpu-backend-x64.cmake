# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME xenia-cpu-backend-x64)
set(SUB_PATH xenia/cpu/backend/x64)

match_platform_files(${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}" "*")
add_library(${NAME} ${LIBRARY_TYPE} ${${NAME}_SOURCES})
target_include_directories(${NAME}
  PRIVATE
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia/src>
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia>)
target_link_libraries(${NAME}
  PRIVATE
    capstone
  PUBLIC
    xenia-cpu)
target_compile_definitions(${NAME}
  PRIVATE
    CAPSTONE_X86_ATT_DISABLE
    CAPSTONE_DIET_NO
    CAPSTONE_X86_REDUCE_NO
    CAPSTONE_HAS_X86
    CAPSTONE_USE_SYS_DYN_MEM
    XBYAK_NO_OP_NAMES
    XBYAK_ENABLE_OMITTED_OPERAND
)

set_target_properties(${NAME} PROPERTIES FOLDER "xenia")
