# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(xenia)

set_property(GLOBAL PROPERTY CMAKE_CXX_STANDARD 17)
set_property(GLOBAL PROPERTY CMAKE_CXX_STANDARD_REQUIRED ON)

option(XENIA_LINK_SHARED "Link libraries as shared instead of static" OFF)

if (MSVC)
  add_compile_options(/arch:AVX)
else()
  add_compile_options(-march=native)
endif()

if (XENIA_LINK_SHARED)
  set(LIBRARY_TYPE SHARED)
else()
  set(LIBRARY_TYPE STATIC)
endif()

# Generate build/version.h using python workaround to call xenia-build command
find_package(Python3 COMPONENTS Interpreter)
add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/build/version.h
  COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/build
  COMMAND Python3::Interpreter ${CMAKE_CURRENT_SOURCE_DIR}/generate_version_h.py
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR})

include(cmake/platform_files.cmake)

include(cmake/xenia-app.cmake)
include(cmake/xenia-app-discord.cmake)
include(cmake/xenia-apu.cmake)
include(cmake/xenia-apu-nop.cmake)
include(cmake/xenia-base.cmake)
if (NOT XENIA_LINK_SHARED)  # No defined entry point
  include(cmake/xenia-base-tests.cmake)
endif()
include(cmake/xenia-core.cmake)
include(cmake/xenia-cpu.cmake)
include(cmake/xenia-cpu-backend-x64.cmake)
# include(cmake/xenia-cpu-tests.cmake)  # out of date
include(cmake/xenia-cpu-ppc-tests.cmake)
include(cmake/xenia-debug-ui.cmake)
include(cmake/xenia-hid.cmake)
include(cmake/xenia-hid-demo.cmake)
include(cmake/xenia-hid-nop.cmake)
include(cmake/xenia-kernel.cmake)
include(cmake/xenia-gpu.cmake)
include(cmake/xenia-gpu-shader-compiler.cmake)
include(cmake/xenia-gpu-null.cmake)
include(cmake/xenia-gpu-vk.cmake)
include(cmake/xenia-gpu-vulkan.cmake)
include(cmake/xenia-gpu-vulkan-trace-viewer.cmake)
include(cmake/xenia-gpu-vulkan-trace-dump.cmake)
include(cmake/xenia-ui.cmake)
include(cmake/xenia-ui-spirv.cmake)
include(cmake/xenia-ui-vk.cmake)
include(cmake/xenia-ui-vulkan.cmake)
include(cmake/xenia-vfs.cmake)
include(cmake/xenia-vfs-dump.cmake)

if (WIN32)
  include(cmake/xenia-apu-xaudio2.cmake)
  include(cmake/xenia-hid-winkey.cmake)
  include(cmake/xenia-hid-xinput.cmake)
  include(cmake/xenia-gpu-d3d12.cmake)
  include(cmake/xenia-gpu-d3d12-trace-viewer.cmake)
  include(cmake/xenia-gpu-d3d12-trace-dump.cmake)
  include(cmake/xenia-ui-d3d12.cmake)
elseif(UNIX)
endif()

include(cmake/third_party/aes_128.cmake)
include(cmake/third_party/capstone.cmake)
include(cmake/third_party/cpptoml.cmake)
include(cmake/third_party/cxxopts.cmake)
include(cmake/third_party/discord-rpc.cmake)
include(cmake/third_party/dxbc.cmake)
include(cmake/third_party/glslang-spirv.cmake)
include(cmake/third_party/imgui.cmake)
include(cmake/third_party/libavutil.cmake)
include(cmake/third_party/libavcodec.cmake)
include(cmake/third_party/mspack.cmake)  # depends on xenia-base
include(cmake/third_party/snappy.cmake)
include(cmake/third_party/spirv-tools.cmake)
include(cmake/third_party/volk.cmake)
include(cmake/third_party/xxhash.cmake)
include(cmake/third_party/yaml-cpp.cmake)

# Specific to linux wip branch
include(cmake/xenia-hid-sdlpad.cmake)
target_link_libraries(xenia
  PRIVATE
    xenia-hid-sdlpad
)
