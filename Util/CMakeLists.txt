add_subdirectory(Serialize)


set(TARGET_NAME Util)

set(HEADERS "2DMatrixCheck.h")

add_library(${TARGET_NAME} INTERFACE)
target_include_directories(${TARGET_NAME} INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(${TARGET_NAME} 
    INTERFACE spdlog::spdlog
    INTERFACE mpark_variant
)