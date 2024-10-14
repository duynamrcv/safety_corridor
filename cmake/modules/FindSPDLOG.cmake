#  Try to find SPDLOG lib
#  The following are set after configuration is done:
#  SPDLOG_FOUND
#  SPDLOG_INCLUDE_DIR
#  SPDLOG_LIBRARY_DIR
#  SPDLOG_LIBRARIES

set(SPDLOG_INCLUDE_DIR "")
set(SPDLOG_LIBRARY_DIR "")
set(SPDLOG_LIBRARIES "")

# Find package
set(SPDLOG_PATH ${VENDOR_PREFIX}/spdlog)
find_file(SPDLOG_FOUND "spdlog/spdlog.h" PATHS ${SPDLOG_PATH}/include)
if (SPDLOG_FOUND)
    list(APPEND SPDLOG_INCLUDE_DIR
        ${SPDLOG_PATH}/include
    )
    list(APPEND SPDLOG_LIBRARY_DIR
        ${SPDLOG_PATH}/lib
    )
    list(APPEND SPDLOG_LIBRARIES
    )
else (SPDLOG_FOUND)
    message(FATAL_ERROR "=====\nspdlog not found! Please check libraries first.\n")
endif(SPDLOG_FOUND)
