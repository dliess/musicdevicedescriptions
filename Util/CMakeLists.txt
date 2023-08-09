set(TARGET_NAME MusicDeviceDescriptionUtil)

set(HEADERS 
    "${CMAKE_CURRENT_SOURCE_DIR}/2DMatrixCheck.h"
    "${CMAKE_CURRENT_SOURCE_DIR}/UtilVectorIndexInRange.h"
)

add_library(${TARGET_NAME} INTERFACE)
target_include_directories(${TARGET_NAME} 
    INTERFACE 
        "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>"
        "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}>"
)
add_library(${PROJECT_NAME}::${TARGET_NAME} ALIAS ${TARGET_NAME})

set_target_properties(${TARGET_NAME} PROPERTIES
    PUBLIC_HEADER "${HEADERS}"
)