# FindTitaniumWindows_Filesystem
# Author: Chris Williams
#
# Copyright (c) 2014 by Appcelerator, Inc. All Rights Reserved.
# Licensed under the terms of the Apache Public License.
# Please see the LICENSE included with this distribution for details.

# Author: Chris Williams
# Created: 2014.12.02

if (${CMAKE_SYSTEM_VERSION} MATCHES "^10.0")
  set(PLATFORM win10)
elseif(${CMAKE_SYSTEM_NAME} STREQUAL "WindowsPhone")
  set(PLATFORM phone)
elseif(${CMAKE_SYSTEM_NAME} STREQUAL "WindowsStore")
  set(PLATFORM store)
else()
  message(FATAL_ERROR "This app supports Store / Phone only.")
endif()

set(TitaniumWindows_Filesystem_ARCH "x86")
if (CMAKE_GENERATOR MATCHES "^Visual Studio .+ ARM$" OR CMAKE_VS_PLATFORM_NAME STREQUAL "ARM")
  set(TitaniumWindows_Filesystem_ARCH "arm")
elseif(CMAKE_GENERATOR MATCHES "^Visual Studio .+ Win64$" OR CMAKE_VS_PLATFORM_NAME STREQUAL "x64")
  set(TitaniumWindows_Filesystem_ARCH "x64")
endif()

# Taken and slightly modified from build's TitaniumWindows_Filesystem_Targets.cmake file
# INTERFACE_INCLUDE_DIRECTORIES is modified to point to our pre-packaged include dir for module

# Create imported target TitaniumWindows_Filesystem
add_library(TitaniumWindows_Filesystem SHARED IMPORTED)

set_target_properties(TitaniumWindows_Filesystem PROPERTIES
  COMPATIBLE_INTERFACE_STRING "TitaniumWindows_Filesystem_MAJOR_VERSION"
  INTERFACE_INCLUDE_DIRECTORIES "${WINDOWS_SOURCE_DIR}/lib/TitaniumWindows_Filesystem/include;$<TARGET_PROPERTY:TitaniumKit,INTERFACE_INCLUDE_DIRECTORIES>;$<TARGET_PROPERTY:TitaniumWindows_Utility,INTERFACE_INCLUDE_DIRECTORIES>"
  INTERFACE_LINK_LIBRARIES "TitaniumKit;TitaniumWindows_Utility"
  INTERFACE_TitaniumWindows_Filesystem_MAJOR_VERSION "0"
)

set_target_properties(TitaniumWindows_Filesystem PROPERTIES
  IMPORTED_IMPLIB "${WINDOWS_SOURCE_DIR}/lib/TitaniumWindows_Filesystem/${PLATFORM}/${TitaniumWindows_Filesystem_ARCH}/TitaniumWindows_Filesystem.lib"
  IMPORTED_LOCATION "${WINDOWS_SOURCE_DIR}/lib/TitaniumWindows_Filesystem/${PLATFORM}/${TitaniumWindows_Filesystem_ARCH}/TitaniumWindows_Filesystem.dll"
  )
