set(PYTHONQT_GENERATED_PATH "")
include( ../build/common.cmake )
add_subdirectory(PythonQt_QtAll)
set(CMAKE_LIB_TARGETS ${CMAKE_LIB_TARGETS} PARENT_SCOPE)
