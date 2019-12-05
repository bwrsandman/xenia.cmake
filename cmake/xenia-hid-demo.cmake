# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME xenia-hid-demo)
set(SUB_PATH xenia/hid)

file(GLOB ${NAME}_SOURCES CONFIGURE_DEPENDS
  "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/hid_demo.cc"
  "${CMAKE_SOURCE_DIR}/xenia/src/base/main_${PLATFORM_SUFFIX}.cc")

add_executable(${NAME} ${${NAME}_SOURCES})

target_include_directories(${NAME}
  PRIVATE
    $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}>
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia>
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia/third_party>)
target_link_libraries(${NAME}
  PRIVATE
    imgui
    volk
    xenia-hid-nop
    xenia-hid-sdlpad
    xenia-ui-vulkan)
if (WIN32)
  target_link_libraries(${NAME}
    PRIVATE
      xenia-hid-winkey
      xenia-hid-xinput)
endif()
set_target_properties(${NAME} PROPERTIES FOLDER "xenia/demos")
