if (${BUILD_TESTS})
   add_subdirectory(UnitTest EXCLUDE_FROM_ALL)
endif()

set(SOURCES
   "MusicDeviceDescription.cpp"
)

set(HEADERS
   "${CMAKE_CURRENT_SOURCE_DIR}/ControllerSection.h"
   "${CMAKE_CURRENT_SOURCE_DIR}/ControllerSection.inl"
   "${CMAKE_CURRENT_SOURCE_DIR}/ControllerSectionMeta.h"
   "${CMAKE_CURRENT_SOURCE_DIR}/ControllerSysExDescription.h"
   "${CMAKE_CURRENT_SOURCE_DIR}/ControllerSysExDescriptionMeta.h"
   "${CMAKE_CURRENT_SOURCE_DIR}/HubSection.h"
   "${CMAKE_CURRENT_SOURCE_DIR}/HubSectionMeta.h"
   "${CMAKE_CURRENT_SOURCE_DIR}/MidiMessageIdsMeta.h"
   "${CMAKE_CURRENT_SOURCE_DIR}/MidiSysexDumpDescrHelper.h"
   "${CMAKE_CURRENT_SOURCE_DIR}/MusicDeviceChains.h"
   "${CMAKE_CURRENT_SOURCE_DIR}/MusicDeviceChainsMeta.h"
   "${CMAKE_CURRENT_SOURCE_DIR}/MusicDeviceDescription.h"
   "${CMAKE_CURRENT_SOURCE_DIR}/MusicDeviceDescriptionMeta.h"
   "${CMAKE_CURRENT_SOURCE_DIR}/SoundSection.h"
   "${CMAKE_CURRENT_SOURCE_DIR}/SoundSection.inl"
   "${CMAKE_CURRENT_SOURCE_DIR}/SoundSectionMeta.h"
   "${CMAKE_CURRENT_SOURCE_DIR}/SoundSysExDescription.h"
   "${CMAKE_CURRENT_SOURCE_DIR}/SoundSysExDescriptionMeta.h"
   "${CMAKE_CURRENT_SOURCE_DIR}/SysExDescription.h"
   "${CMAKE_CURRENT_SOURCE_DIR}/SysExDescriptionMeta.h"
)

set(TARGET_NAME MusicDeviceDescription)

add_library(${TARGET_NAME} STATIC ${SOURCES} ${HEADERS})
add_library(${PROJECT_NAME}::${TARGET_NAME} ALIAS ${TARGET_NAME})
target_include_directories(${TARGET_NAME} 
   PUBLIC 
      "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>"
      "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}>"
)
target_link_libraries(${TARGET_NAME}
   PUBLIC MetaStuff::SerializeJson
   PUBLIC Variant::Variant
   PUBLIC Util
   PUBLIC MIDI::midi
   PUBLIC magic_enum::magic_enum
)

set_target_properties(${TARGET_NAME} PROPERTIES
    PUBLIC_HEADER "${HEADERS}"
)