################################################################
cmake_minimum_required(VERSION 3.25)
################################################################
set(LIBRARY_NAME "dev-tools")
set(LIBRARY_DESC "Library that supports C++ development.")

project(libict-${LIBRARY_NAME})

set(CMAKE_CXX_STANDARD 17)
find_package(Threads)

add_executable(${PROJECT_NAME}-test test.hpp test.cpp)
target_link_libraries(${PROJECT_NAME}-test ${CMAKE_THREAD_LIBS_INIT})
target_link_libraries(${PROJECT_NAME}-test ${CMAKE_LINK_LIBS})
target_compile_definitions(${PROJECT_NAME}-test PUBLIC -DENABLE_TESTING)

################################################################
enable_testing()

add_test(NAME ict-dev-tools-tc1 COMMAND ${PROJECT_NAME}-test ict dev_tools tc1)

include(../cpack-include.cmake)
################################################################