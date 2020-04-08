# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME xenia-base)
set(SUB_PATH xenia/base)

match_platform_files(${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}" "*")
list(FILTER ${NAME}_SOURCES EXCLUDE REGEX "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/exception_handler_posix.cc")
add_library(${NAME} ${LIBRARY_TYPE} ${${NAME}_SOURCES} ${CMAKE_BINARY_DIR}/build/version.h)
target_include_directories(${NAME}
  PRIVATE
    $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}>
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia>
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia/third_party>
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia/src>
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia)
if (UNIX)
  find_package(PkgConfig REQUIRED)
  pkg_check_modules(GTK3 REQUIRED gtk+-3.0)

  # PUBLIC because base/platform_linux.h leaks gdk/gdkx.h
  target_include_directories(${NAME} PUBLIC ${GTK3_INCLUDE_DIRS})
  link_directories(${GTK3_LIBRARY_DIRS}) # target_link_directories introduced in 3.13
  # target_link_directories(${NAME} PRIVATE ${GTK3_LIBRARY_DIRS})
  target_link_libraries(${NAME} PRIVATE ${GTK3_LIBRARIES} rt)
  target_compile_options(${NAME} PRIVATE ${GTK3_CFLAGS_OTHER})
endif()
find_package(Threads)
target_link_libraries(${NAME} PRIVATE fmt cpptoml Threads::Threads)
set_target_properties(${NAME} PROPERTIES FOLDER "xenia")
