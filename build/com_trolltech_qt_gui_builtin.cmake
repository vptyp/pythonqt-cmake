file(GLOB com_trolltech_qt_gui_builtin_SOURCES 
    ${PYTHONQT_GENERATED_PATH}/com_trolltech_qt_gui_builtin/*.cpp)
file(GLOB com_trolltech_qt_gui_builtin_HEADERS 
    ${PYTHONQT_GENERATED_PATH}/com_trolltech_qt_gui_builtin/*.h)

list(APPEND HEADERS 
    ${com_trolltech_qt_gui_builtin_HEADERS} )

list(APPEND SOURCES
    ${com_trolltech_qt_gui_builtin_SOURCES} )