#  Try to find JSON lib
#  The following are set after configuration is done:
#  JSON_FOUND
#  JSON_INCLUDE_DIR
#  JSON_LIBRARY_DIR
#  JSON_LIBRARIES

set(JSON_INCLUDE_DIR "")
set(JSON_LIBRARY_DIR "")
set(JSON_LIBRARIES "")

# Find package
set(JSON_PATH ${VENDOR_PREFIX}/json)
find_file(JSON_FOUND "json.hpp" PATHS ${JSON_PATH}/include)
if (JSON_FOUND)
    list(APPEND JSON_INCLUDE_DIR
        ${JSON_PATH}/include
    )
else (JSON_FOUND)
    message(FATAL_ERROR "=====\JSON not found! Please install JSON first.\n")
endif(JSON_FOUND)



