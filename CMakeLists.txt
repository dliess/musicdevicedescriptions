cmake_minimum_required(VERSION 3.15)
set (CMAKE_CXX_STANDARD 20)
set(CMAKE_DEBUG_POSTFIX _g)

project(MusicDeviceDescriptions LANGUAGES CXX)
include(GNUInstallDirs)

include(CTest)
option (BUILD_TESTS "build tests enabled" ON)
if (${BUILD_TESTS})
   message(STATUS "Build with Unit Tests")
   enable_testing()
endif()

include(cmake/CPM.cmake)

CPMFindPackage(
  NAME midi
  GITHUB_REPOSITORY dliess/Midi
  #GIT_REPOSITORY git@danita-hp:app/Midi.git
  GIT_TAG d64ac0fb3e79227ef2d26b3b7e0d24a4be48d8a7
)
if(midi_ADDED)
  add_library(MIDI::midi ALIAS midi)
  add_library(MIDI::usbmidi ALIAS usbmidi)
endif()

CPMFindPackage(
  NAME mpark_variant
  GITHUB_REPOSITORY mpark/variant
  VERSION 1.4.0
)

find_package(spdlog 1.8.1 CONFIG REQUIRED)

CPMFindPackage(
  NAME nlohmann_json
  GITHUB_REPOSITORY nlohmann/json
  VERSION 3.9.1
  OPTIONS
    "JSON_BuildTests OFF"
)
if(nlohmann_json_ADDED)
  add_library(nlohmann_json::nlohmann_json ALIAS nlohmann_json)
endif()

CPMFindPackage(
  NAME MetaStuff
  GIT_REPOSITORY git@github.com:dliess/MetaStuff.git
  GIT_TAG develop
  OPTIONS
    "WITH_EXAMPLES OFF"
)
if(MetaStuff_ADDED)
  add_library(MetaStuff::MetaStuff ALIAS MetaStuff)
endif()

add_subdirectory(Util)
add_subdirectory(MusicDeviceDescription)