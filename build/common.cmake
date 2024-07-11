# Set the version
set(VERSION "3.2.0")

if(NOT ${HAVE_PARENT})
  find_package(QT NAMES Qt5 Qt6 REQUIRED COMPONENTS Core)
  find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Gui)
  find_package(Qt${QT_VERSION_MAJOR} OPTIONAL_COMPONENTS Widgets)
endif()

# Determine the path to generated files
set(PYTHONQT_GENERATED_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../generated_cpp" PARENT_SCOPE)
if(NOT EXISTS ${PYTHONQT_GENERATED_PATH})
  set(PYTHONQT_GENERATED_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../generated_cpp_${QT_VERSION_MAJOR}${QT_VERSION_MINOR}")

  if(NOT EXISTS ${PYTHONQT_GENERATED_PATH})
    if(${QT_VERSION_MAJOR} EQUAL 5)
      if(${QT_VERSION_MINOR} EQUAL 10)
        set(PYTHONQT_GENERATED_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../generated_cpp_56")
      elseif(${QT_VERSION_MINOR} EQUAL 11 OR ${QT_VERSION_MINOR} EQUAL 12)
        set(PYTHONQT_GENERATED_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../generated_cpp_511")
      elseif(${QT_VERSION_MINOR} EQUAL 1 OR ${QT_VERSION_MINOR} EQUAL 2)
        set(PYTHONQT_GENERATED_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../generated_cpp_50")
      elseif(${QT_VERSION_MINOR} EQUAL 3)
        set(PYTHONQT_GENERATED_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../generated_cpp_53")
      elseif(${QT_VERSION_MINOR} EQUAL 4 OR ${QT_VERSION_MINOR} EQUAL 5)
        set(PYTHONQT_GENERATED_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../generated_cpp_54")
      elseif(${QT_VERSION_MINOR} EQUAL 6 OR ${QT_VERSION_MINOR} EQUAL 7 OR ${QT_VERSION_MINOR} EQUAL 8 OR ${QT_VERSION_MINOR} EQUAL 9)
        set(PYTHONQT_GENERATED_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../generated_cpp_56")
      else()
        set(PYTHONQT_GENERATED_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../generated_cpp_56")
      endif()
    endif()
  endif()
endif()

# Enable C++11 if Qt version is greater than 5.9
if(QT_VERSION_MAJOR GREATER 5 OR (QT_VERSION_MAJOR EQUAL 5 AND QT_VERSION_MINOR GREATER 9))
  set(CMAKE_CXX_STANDARD 11)
endif()

# Platform-specific configurations
if(WIN32)
  add_definitions(-Dskip_target_version_ext)
endif()
#    
#    
if(CMAKE_COMPILER_IS_GNUCXX OR (WIN32 AND CMAKE_CXX_COMPILER_ID MATCHES "Clang|MSVC"))
  add_compile_options(
    -Wno-deprecated-declarations
    -Winit-self
    -Wl,--no-undefined
    -Wuninitialized
    -ansi
    -pedantic
  )
endif()

if(WIN32 AND CMAKE_CXX_COMPILER_ID MATCHES "Clang|MSVC")
  add_compile_options(-Wno-unused-command-line-argument)
endif()

# Do not issue warning to system includes
if(CMAKE_COMPILER_IS_GNUCXX AND NOT QT_INSTALL_HEADERS STREQUAL "")
  include_directories(SYSTEM ${QT_INSTALL_HEADERS})
endif()

message(STATUS "Generated path: ${PYTHONQT_GENERATED_PATH}")
