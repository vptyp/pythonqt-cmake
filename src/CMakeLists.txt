project(PythonQt-Qt5-Python3)

if(NOT ${HAVE_PARENT})
    find_package(QT NAMES Qt5 Qt6 REQUIRED COMPONENTS Core)
    find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Gui)
    find_package(Qt${QT_VERSION_MAJOR} OPTIONAL_COMPONENTS Widgets)
endif()

add_library(${PROJECT_NAME} SHARED)

include( ../build/common.cmake )
find_package(Python 
    REQUIRED COMPONENTS Interpreter Development)
message(STATUS "Python interpreter found at: ${Python_EXECUTABLE}")
message(STATUS "Python_INCLUDE_DIRS: ${Python_INCLUDE_DIRS}")
message(STATUS "Python_LIBRARIES: ${Python_LIBRARIES}")

include (src.cmake)
include (../build/com_trolltech_qt_core_builtin.cmake)
include (../build/com_trolltech_qt_gui_builtin.cmake)

target_sources(${PROJECT_NAME} PRIVATE
    ${HEADERS} 
    ${SOURCES}
)

target_link_libraries(${PROJECT_NAME} PUBLIC
    Qt${QT_VERSION_MAJOR}::Core 
    Qt${QT_VERSION_MAJOR}::Gui
    Qt${QT_VERSION_MAJOR}::CorePrivate 
    Qt${QT_VERSION_MAJOR}::Widgets
    Python::Python
    Python::Module
)
    
target_include_directories(${PROJECT_NAME} PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
        $<INSTALL_INTERFACE:include>
)

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
