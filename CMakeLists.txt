cmake_minimum_required(VERSION 3.15)
set (CMAKE_CXX_STANDARD 20)
set(CMAKE_DEBUG_POSTFIX _g)

project(MusicDeviceDescriptions 
        LANGUAGES CXX
        VERSION 0.0.1)
include(GNUInstallDirs)

include(CTest)
option (BUILD_TESTS "build tests enabled" ON)
if (${BUILD_TESTS})
   message(STATUS "Build with Unit Tests")
   enable_testing()
endif()

option (USE_MPARK_VARIANT "use mpark variant" ON)

include(cmake/CPM.cmake)

CPMFindPackage(
  NAME midi
  GITHUB_REPOSITORY dliess/Midi
  #GIT_REPOSITORY git@danita-hp:app/Midi.git
  GIT_TAG master
  OPTIONS
    "USE_MPARK_VARIANT ${USE_MPARK_VARIANT}"
)
if(midi_ADDED)
  add_library(MIDI::midi ALIAS midi)
  add_library(MIDI::usbmidi ALIAS usbmidi)
endif()

CPMFindPackage(
  NAME Variant
  GITHUB_REPOSITORY dliess/variant
  GIT_TAG master
  OPTIONS
    "USE_MPARK_VARIANT ${USE_MPARK_VARIANT}"
)

find_package(spdlog 1.8.1 CONFIG REQUIRED)

if(${BUILD_TESTS})
  find_package(GTest REQUIRED)
  list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
  find_package(GMock REQUIRED)
  include_directories(${GMOCK_INCLUDE_DIRS}) 
endif()

CPMFindPackage(
  NAME MetaStuff
  GIT_REPOSITORY git@github.com:dliess/MetaStuff.git
  GIT_TAG develop
  OPTIONS
    "WITH_EXAMPLES OFF"
    "USE_MPARK_VARIANT ${USE_MPARK_VARIANT}"
)

CPMFindPackage(
  NAME magic_enum
  GITHUB_REPOSITORY Neargye/magic_enum
  VERSION 0.9.0
  OPTIONS
    "MAGIC_ENUM_OPT_INSTALL ON"
)

add_subdirectory(Util)
add_subdirectory(MusicDeviceDescription)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/${PROJECT_NAME}Config.cmake.in 
               ${CMAKE_CURRENT_BINARY_DIR}/cmake/${PROJECT_NAME}Config.cmake @ONLY)

install(
  TARGETS MusicDeviceDescriptionUtil MusicDeviceDescription
  EXPORT ${PROJECT_NAME}-targets
  PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}
)

install(EXPORT ${PROJECT_NAME}-targets
    NAMESPACE
        ${PROJECT_NAME}::
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
)

include(CMakePackageConfigHelpers)
write_basic_package_version_file("${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config-version.cmake" COMPATIBILITY SameMajorVersion)
install(FILES 
           "${CMAKE_CURRENT_BINARY_DIR}/cmake/${PROJECT_NAME}Config.cmake"
           "${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config-version.cmake" 
        DESTINATION 
           "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")

#install(
#  DIRECTORY "MidiConfigs"
#  DESTINATION "/etc/nomidi-backend/"
#)