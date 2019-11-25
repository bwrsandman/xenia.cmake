# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME xenia-cpu-ppc-tests)
set(SUB_PATH xenia/cpu/ppc/testing)

list(APPEND ${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/ppc_testing_main.cc")
list(APPEND ${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/xenia/base/main${PLATFORM_SUFFIX}.cc")

add_executable(${NAME} ${${NAME}_SOURCES})
target_compile_definitions(${NAME} PRIVATE CATCH_CONFIG_MAIN)
target_include_directories(${NAME}
  PRIVATE
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia>
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia/src>)
target_link_libraries(${NAME} PRIVATE xenia-cpu-backend-x64 xenia-core xenia-base)
set_target_properties(${NAME} PROPERTIES FOLDER "xenia/tests")

enable_testing()
add_test(${NAME} COMMAND ${NAME})
