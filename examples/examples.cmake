# Get the linked libraries of the project
get_target_property(LINK_LIBRARIES ${PROJECT_NAME} LINK_LIBRARIES)
message(STATUS "${PROJECT_NAME} linked libraries: ${LINK_LIBRARIES}")

set(LIBRARIES_PATHS "")

function(get_target_link_libraries_recursive TARGET OUT_LIBRARIES)
    if(NOT TARGET ${TARGET})
        return()
    endif()

    get_target_property(LINK_LIBRARIES ${TARGET} LINK_LIBRARIES)
    if(LINK_LIBRARIES)
        foreach(LIBRARY ${LINK_LIBRARIES})
            if(NOT LIBRARY IN_LIST OUT_LIBRARIES)
                list(APPEND OUT_LIBRARIES ${LIBRARY})
                get_target_link_libraries_recursive(${LIBRARY} ${OUT_LIBRARIES})
            endif()
        endforeach()
    endif()
endfunction()

set(ALL_LIBRARIES ${LINK_LIBRARIES})
foreach(LIBRARY ${LINK_LIBRARIES})
    get_target_link_libraries_recursive(${LIBRARY} ${ALL_LIBRARIES})
endforeach()

foreach(LIBRARY ${ALL_LIBRARIES})
    get_target_property(LIBRARY_TYPE ${LIBRARY} TYPE)
    if(NOT LIBRARY_TYPE STREQUAL "INTERFACE_LIBRARY")
#        get_target_property(LIBRARY_PATH ${LIBRARY} LOCATION)
        list(APPEND LIBRARIES_PATHS $<TARGET_FILE:${LIBRARY}>)
    endif()
endforeach()

# Remove duplicates in LIBRARIES_PATHS
list(REMOVE_DUPLICATES LIBRARIES_PATHS)

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        ${LIBRARIES_PATHS}
        $<TARGET_FILE_DIR:${PROJECT_NAME}>
)
