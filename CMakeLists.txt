cmake_minimum_required(VERSION 3.12)
project(PythonQt)

set(CMAKE_CXX_STANDARD 17)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

if(NOT DEFINED ${HAVE_PARENT})
    message(STATUS "BUILDING EXAMPLES")

    set(EXAMPLES ON)
endif()

add_subdirectory(src)
add_subdirectory(extensions)
if(${EXAMPLES} STREQUAL "ON")
    message(STATUS "BUILDING EXAMPLES")
    add_subdirectory(examples)
endif()
if(${HAVE_PARENT})
    set(CMAKE_LIB_TARGETS ${CMAKE_LIB_TARGETS} PARENT_SCOPE)
endif()