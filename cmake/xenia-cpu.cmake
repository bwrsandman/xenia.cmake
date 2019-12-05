# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME xenia-cpu)
set(SUB_PATH xenia/cpu)

match_platform_files(${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}" "*")
match_platform_files(${NAME}_BACKEND_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/backend" "*")
match_platform_files(${NAME}_COMPILER_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/compiler" "*")
match_platform_files(${NAME}_COMPILER_PASSES_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/compiler/passes" "*")
match_platform_files(${NAME}_HIR_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/hir" "*")
match_platform_files(${NAME}_PPC_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/ppc" "*")
add_library(${NAME} ${LIBRARY_TYPE}
  ${${NAME}_SOURCES}
  ${${NAME}_BACKEND_SOURCES}
  ${${NAME}_COMPILER_SOURCES}
  ${${NAME}_COMPILER_PASSES_SOURCES}
  ${${NAME}_HIR_SOURCES}
  ${${NAME}_PPC_SOURCES})
if (UNIX)
  find_library(IBERTY_LIBRARY iberty REQUIRED)
  find_library(UNWIND_LIBRARY unwind REQUIRED)
endif()
target_include_directories(${NAME}
  PRIVATE
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia/src>
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia>
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia/third_party/llvm/include>
  # PUBLIC because /cpu/cpu_flags.h leaks cpptoml include
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia/third_party>)
find_package(LLVM REQUIRED CONFIG)
llvm_map_components_to_libnames(llvm_libs support)
target_link_libraries(${NAME} PRIVATE mspack ${llvm_libs} ${IBERTY_LIBRARY} ${UNWIND_LIBRARY})
set_target_properties(${NAME} PROPERTIES FOLDER "xenia")
