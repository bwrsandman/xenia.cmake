function(match_platform_files list_name base_path base_match)
  if (WIN32)
    set(PLATFORM_SUFFIX _win PARENT_SCOPE)
    file(GLOB PLATFORM_FILES CONFIGURE_DEPENDS
      ${base_path}/${base_match}${PLATFORM_SUFFIX}.h
      ${base_path}/${base_match}${PLATFORM_SUFFIX}.cc)
  elseif(CYGWIN)
  elseif(MINGW)
  elseif(APPLE)
  elseif(UNIX)
    set(PLATFORM_SUFFIX _posix PARENT_SCOPE)
    file(GLOB PLATFORM_FILES CONFIGURE_DEPENDS
      ${base_path}/${base_match}${PLATFORM_SUFFIX}.h
      ${base_path}/${base_match}${PLATFORM_SUFFIX}.cc
      ${base_path}/${base_match}_linux.h
      ${base_path}/${base_match}_linux.cc
      ${base_path}/${base_match}_x11.h
      ${base_path}/${base_match}_x11.cc
      ${base_path}/${base_match}_gtk.h
      ${base_path}/${base_match}_gtk.cc)
  endif()

  file(GLOB SOURCES CONFIGURE_DEPENDS
    ${base_path}/${base_match}.h
    ${base_path}/${base_match}.c
    ${base_path}/${base_match}.cc
    ${base_path}/${base_match}.cpp
    ${base_path}/${base_match}.inc
  )

  list(FILTER SOURCES EXCLUDE REGEX "${base_path}/.*_main.cc$")
  list(FILTER SOURCES EXCLUDE REGEX "${base_path}/.*_test.cc$")
  list(FILTER SOURCES EXCLUDE REGEX "${base_path}/.*_posix.h$")
  list(FILTER SOURCES EXCLUDE REGEX "${base_path}/.*_posix.cc$")
  list(FILTER SOURCES EXCLUDE REGEX "${base_path}/.*_linux.h$")
  list(FILTER SOURCES EXCLUDE REGEX "${base_path}/.*_linux.cc$")
  list(FILTER SOURCES EXCLUDE REGEX "${base_path}/.*_x11.h$")
  list(FILTER SOURCES EXCLUDE REGEX "${base_path}/.*_x11.cc$")
  list(FILTER SOURCES EXCLUDE REGEX "${base_path}/.*_gtk.h$")
  list(FILTER SOURCES EXCLUDE REGEX "${base_path}/.*_gtk.cc$")
  list(FILTER SOURCES EXCLUDE REGEX "${base_path}/.*_mac.h$")
  list(FILTER SOURCES EXCLUDE REGEX "${base_path}/.*_mac.cc$")
  list(FILTER SOURCES EXCLUDE REGEX "${base_path}/.*_win.h$")
  list(FILTER SOURCES EXCLUDE REGEX "${base_path}/.*_win.cc$")

  list(APPEND SOURCES ${PLATFORM_FILES})

  set(${list_name} ${SOURCES} PARENT_SCOPE)
endfunction()
