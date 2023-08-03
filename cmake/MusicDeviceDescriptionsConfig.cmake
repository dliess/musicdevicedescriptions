get_filename_component(_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
include(CMakeFindDependencyMacro)

find_dependency(midi REQUIRED)

if(NOT TARGET Push2Device::Push2Device)
    include("${Push2Device_CMAKE_DIR}/@PROJECT_NAME@-targets.cmake")
endif()