# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

set(NAME xenia)
set(SUB_PATH xenia/app)

match_platform_files(${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}" "*")
list(APPEND ${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/${SUB_PATH}/xenia_main.cc")
list(APPEND ${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/xenia/base/main_init${PLATFORM_SUFFIX}.cc")
list(APPEND ${NAME}_SOURCES "${CMAKE_SOURCE_DIR}/xenia/src/xenia/base/main${PLATFORM_SUFFIX}.cc")

add_executable(${NAME} ${${NAME}_SOURCES})
target_compile_definitions(${NAME} PRIVATE XBYAK_NO_OP_NAMES XBYAK_ENABLE_OMITTED_OPERAND)
target_include_directories(${NAME} PRIVATE
  $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}>
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia>
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/xenia/third_party>)
target_link_libraries(${NAME}
    PRIVATE
      xenia-app-discord
      xenia-apu-nop
      xenia-core
      xenia-cpu-backend-x64
      xenia-debug-ui
      xenia-gpu-null
      xenia-gpu-vk
      xenia-gpu-vulkan
      xenia-hid-nop
      xenia-kernel
      xenia-ui-spirv
      xenia-ui-vk
      xenia-ui-vulkan
      xenia-vfs
)

if (WIN32)
  target_link_libraries(${NAME}
    PRIVATE
      xenia-apu-xaudio2
      xenia-gpu-d3d12
      xenia-hid-winkey
      xenia-hid-xinput
      xenia-ui-d3d12
  )
elseif(UNIX)
endif()
