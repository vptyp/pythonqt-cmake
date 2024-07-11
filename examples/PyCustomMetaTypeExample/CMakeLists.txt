project(PyCustomMetaTypeExample)

include(../../build/common.cmake)

add_executable(${PROJECT_NAME})

file(GLOB SOURCES *.cpp)
file(GLOB HEADERS *.h)
file(GLOB FORMS *.ui)
file(GLOB RESOURCES *.qrc)

target_sources(${PROJECT_NAME} PRIVATE
    ${SOURCES}
    ${HEADERS}
    ${FORMS}
    ${RESOURCES}
)

target_link_libraries(${PROJECT_NAME} PRIVATE
Qt${QT_VERSION_MAJOR}::Core 
Qt${QT_VERSION_MAJOR}::Gui
Qt${QT_VERSION_MAJOR}::Widgets
PythonQt-Qt5-Python3
PythonQt_QtAll-Qt5-Python3
)

include(../examples.cmake)

install(TARGETS ${PROJECT_NAME}
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib
        RUNTIME DESTINATION bin
)
