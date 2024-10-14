cmake_minimum_required(VERSION 3.5)
project(lightweight_ogm)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)

# Generate the compile_commands.json file
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)

# Set the relative path configurations
set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

# Configure the visibility of symbols in targets
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN 1)

# Define installation folder and the module path (this one required by conan)
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/install)
set(CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR} ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR} ${CMAKE_PREFIX_PATH})

# output dir
if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build, options are: Debug Release RelWithDebInfo MinSizeRel." FORCE)
endif()
if (${CMAKE_BUILD_TYPE} STREQUAL "Release")
    set(BUILD_TYPE_STR "release")
else ()
    set(BUILD_TYPE_STR "debug")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D_DEBUG -g -O0")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D_DEBUG -g -O0")
endif()

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${BUILD_TYPE_STR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${BUILD_TYPE_STR}/bin)

# generic c/c++ flags
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -std=c++17 -Werror -Wall -Wextra -Wno-packed-bitfield-compat -fdiagnostics-color=always")
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DEIGEN_MPL2_ONLY -fPIC -Werror -Wall -Wextra -Wno-packed-bitfield-compat")


# some macros
include("${CMAKE_SOURCE_DIR}/cmake/macros/Message.cmake")
include("${CMAKE_SOURCE_DIR}/cmake/macros/Vendors.cmake")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PROJECT_SOURCE_DIR}/cmake/modules")

# dependencies
include (${CMAKE_SOURCE_DIR}/cmake/Dependencies.cmake)

# into the project
add_subdirectory(safety_corridor)
add_subdirectory(example)