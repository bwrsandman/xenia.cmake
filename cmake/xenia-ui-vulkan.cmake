# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME xenia-ui-vulkan)
set(SUB_PATH xenia/ui/vulkan)

match_platform_files(${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}" "*")
list(FILTER ${NAME}_SOURCES EXCLUDE REGEX ".*_demo.cc$")
file(GLOB SHADERS CONFIGURE_DEPENDS ${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/shaders/bin/*.h)
add_library(${NAME} ${LIBRARY_TYPE} ${${NAME}_SOURCES} ${SHADERS})
target_include_directories(${NAME}
  PRIVATE
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia>
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia/third_party>
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia/src>)
find_package(Vulkan REQUIRED)
target_link_libraries(${NAME} PRIVATE xenia-ui-spirv Vulkan::Vulkan volk PUBLIC xenia-ui)
if(UNIX)
  find_package(X11 REQUIRED)
  target_include_directories(${NAME} PRIVATE ${X11_INCLUDE_DIR})
  target_link_libraries(${NAME} PRIVATE ${X11_LIBRARIES} X11-xcb)
endif()
set_target_properties(${NAME} PROPERTIES FOLDER "xenia")
