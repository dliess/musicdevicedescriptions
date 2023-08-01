if (${BUILD_TESTS})
   add_subdirectory(UnitTest EXCLUDE_FROM_ALL)
endif()

set(SOURCES
   "MusicDeviceDescription.cpp"
)

set(HEADERS
   "ControllerSection.h"
   "ControllerSection.inl"
   "ControllerSectionMeta.h"
   "ControllerSysExDescription.h"
   "ControllerSysExDescriptionMeta.h"
   "HubSection.h"
   "HubSectionMeta.h"
   "MidiMessageIdsMeta.h"
   "MidiSysexDumpDescrHelper.h"
   "MusicDeviceChains.h"
   "MusicDeviceChainsMeta.h"
   "MusicDeviceDescription.h"
   "MusicDeviceDescriptionMeta.h"
   "SoundSection.h"
   "SoundSection.inl"
   "SoundSectionMeta.h"
   "SoundSysExDescription.h"
   "SoundSysExDescriptionMeta.h"
   "SysExDescription.h"
   "SysExDescriptionMeta.h"
)

set(TARGET_NAME MusicDeviceDescription)

add_library(${TARGET_NAME} STATIC ${SOURCES} ${HEADERS})
target_include_directories(${TARGET_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(${TARGET_NAME}
   PUBLIC UtilSerialize
   PUBLIC Util
   PUBLIC MIDI::midi
   PUBLIC magic_enum::magic_enum
)