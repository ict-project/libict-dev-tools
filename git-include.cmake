if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/../.git)
  find_package(Git)
  if(GIT_FOUND)
    execute_process(
      COMMAND ${GIT_EXECUTABLE} describe
      WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
      OUTPUT_VARIABLE "GIT_DESCRIBE"
      ERROR_QUIET
      OUTPUT_STRIP_TRAILING_WHITESPACE)
    string(REGEX REPLACE "^v?([0-9]+)\\.([0-9]+)(-([0-9]+))?.*" "\\1.\\2" GIT_VERSION "${GIT_DESCRIBE}")
    if(NOT GIT_VERSION MATCHES "^v?([0-9]+)\\.([0-9]+)-.+$")
      string(REGEX REPLACE "^v?([0-9]+)\\.([0-9]+)-([0-9]+).*" "\\1.\\2.\\3" GIT_VERSION "${GIT_DESCRIBE}")
    endif()
    message( STATUS "Repo version: ${GIT_VERSION}" )
  else(GIT_FOUND)
    set(GIT_VERSION unknown)
  endif(GIT_FOUND)
else(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/../.git)
 set(GIT_VERSION unknown)
endif(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/../.git)