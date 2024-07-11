project(PythonQt_QtAll-Qt5-Python3)

if(NOT DEFINED ${HAVE_PARENT})
    find_package(QT NAMES Qt5 Qt6 REQUIRED COMPONENTS Core)
    find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Gui)
    find_package(Qt${QT_VERSION_MAJOR} OPTIONAL_COMPONENTS Widgets)
endif()

add_definitions(-DPYTHONQT_QTALL_EXPORTS)

add_library(${PROJECT_NAME} SHARED
    PythonQt_QtAll.cpp PythonQt_QtAll.h)

find_package(Python 
    REQUIRED COMPONENTS Interpreter Development)

message(STATUS "PYTHON_GENERATED_PATH: ${PYTHONQT_GENERATED_PATH}")
# Set PYTHONQT_GENERATED_PATH if not defined
if(${PYTHONQT_GENERATED_PATH} STREQUAL "")
    message(STATUS "PYTHONQT_GENERATED_PATH not defined. This is error")
    set(PYTHONQT_GENERATED_PATH "path/to/generated")  # Replace with actual path
endif()

# Function to include module source and header files
function(Xinclude module)
    set(source_dir "${PYTHONQT_GENERATED_PATH}/${module}")
    file(GLOB_RECURSE module_sources "${source_dir}/*.cpp" "${source_dir}/*.c")
    file(GLOB_RECURSE module_headers "${source_dir}/*.h")
    set(SOURCES ${SOURCES} ${module_sources} PARENT_SCOPE)
    set(HEADERS ${HEADERS} ${module_headers} PARENT_SCOPE)
endfunction()

# Default configuration
set(DEFAULT_PYTHONQT_MODULES
    PythonQtCore
    PythonQtGui
    PythonQtSvg
    PythonQtSql
    PythonQtNetwork
    PythonQtOpengl
    PythonQtXml
    PythonQtXmlpatterns
    PythonQtMultimedia
    PythonQtQml
    PythonQtQuick
    PythonQtUiTools
    PythonQtWebKit
)

# Check if PYTHONQTALL_CONFIG is set
if(NOT DEFINED ${PYTHONQTALL_CONFIG})
    message("Using default PythonQt_QtAll Configuration")
    set(PYTHONQTALL_CONFIG "${DEFAULT_PYTHONQT_MODULES}")
else()
    message("Using given PythonQt_QtAll Configuration: ${PYTHONQTALL_CONFIG}")
endif()

set(PythonQtCore Core)
set(PythonQtGui Gui Widgets PrintSupport)
set(PythonQtSvg Svg)
set(PythonQtSql Sql)
set(PythonQtNetwork Network)
set(PythonQtOpengl OpenGL)
set(PythonQtXml Xml)
set(PythonQtXmlpatterns XmlPatterns)
set(PythonQtMultimedia Multimedia MultimediaWidgets)
set(PythonQtQml Qml)
set(PythonQtQuick Quick QuickWidgets)
set(PythonQtUiTools UiTools)
set(PythonQtWebKit WebKit WebKitWidgets)


# Configure modules
set(SOURCES "")
set(HEADERS "")
set(QT_LIBRARIES )
foreach(module ${PYTHONQTALL_CONFIG})
    foreach(mod ${${module}})
        find_package(Qt${QT_VERSION_MAJOR} QUIET COMPONENTS ${mod})
        if(${Qt${QT_VERSION_MAJOR}${mod}_FOUND})
            add_definitions(-DPYTHONQT_WITH_${mod})
            Xinclude(${module})
            list(APPEND QT_LIBRARIES Qt${QT_VERSION_MAJOR}::${mod})
        endif()
    endforeach()
endforeach()

# Add executable and link libraries
target_sources(${PROJECT_NAME} PRIVATE ${SOURCES} ${HEADERS})

target_link_libraries(${PROJECT_NAME} PRIVATE
    ${QT_LIBRARIES}
    PythonQt-Qt5-Python3
    Python::Python
    Python::Module
)

target_include_directories(${PROJECT_NAME} PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
        $<INSTALL_INTERFACE:include>
)
message(STATUS "CMAKE PREFIX QT_ALL: ${CMAKE_INSTALL_PREFIX}")
install(TARGETS ${PROJECT_NAME}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
        LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
        RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
)

install(
        FILES ${HEADERS}
        DESTINATION include/${PROJECT_NAME}
)

set(CMAKE_LIB_TARGETS ${CMAKE_LIB_TARGETS} ${PROJECT_NAME} PARENT_SCOPE)
