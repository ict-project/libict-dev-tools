################################################################
cmake_minimum_required(VERSION 3.25)
################################################################
set(LIBRARY_NAME "template")
set(LIBRARY_DESC "Library template")

project(libict-${LIBRARY_NAME})

set(CMAKE_CXX_STANDARD 17)
find_package(Threads)

include(../libict-dev-tools/libs-include.cmake)
include(../libict-dev-tools/info-include.cmake)
include(../libict-dev-tools/test-include.cmake)
include(../libict-dev-tools/git-include.cmake)

file(GLOB CMAKE_HEADER_LIST . *.hpp)

set(CMAKE_SOURCE_FILES 
  info.cpp
  # ...
)

add_library(ict-static-${LIBRARY_NAME} STATIC ${CMAKE_SOURCE_FILES})
target_link_libraries(ict-static-${LIBRARY_NAME} ${CMAKE_THREAD_LIBS_INIT})
set_target_properties(ict-static-${LIBRARY_NAME}  PROPERTIES OUTPUT_NAME ict-${LIBRARY_NAME})

add_library(ict-shared-${LIBRARY_NAME} SHARED ${CMAKE_SOURCE_FILES})
target_link_libraries(ict-shared-${LIBRARY_NAME} ${CMAKE_THREAD_LIBS_INIT})
set_target_properties(ict-shared-${LIBRARY_NAME}  PROPERTIES OUTPUT_NAME ict-${LIBRARY_NAME})

if (CMAKE_BUILD_TYPE MATCHES Debug OR CMAKE_BUILD_TYPE MATCHES RelWithDebInfo)
  add_executable(${PROJECT_NAME}-test ${CMAKE_HEADER_LIST} ${CMAKE_SOURCE_FILES} test.cpp)
  target_link_libraries(${PROJECT_NAME}-test ${CMAKE_THREAD_LIBS_INIT})
  target_link_libraries(${PROJECT_NAME}-test ${CMAKE_LINK_LIBS})
  target_compile_definitions(${PROJECT_NAME}-test PUBLIC -DENABLE_TESTING)
endif()

################################################################
install(TARGETS ict-static-${LIBRARY_NAME} ict-shared-${LIBRARY_NAME} DESTINATION lib COMPONENT libraries)
install(
  FILES ${CMAKE_HEADER_LIST}
  DESTINATION include/libict/${LIBRARY_NAME} COMPONENT headers
)
################################################################
if (CMAKE_BUILD_TYPE MATCHES Debug OR CMAKE_BUILD_TYPE MATCHES RelWithDebInfo)
  enable_testing()
  add_test(NAME ict-template-tc1 COMMAND ${PROJECT_NAME}-test ict template tc1)
  # ...
endif()
################################################################
include(../libict-dev-tools/cpack-include.cmake)
################################################################