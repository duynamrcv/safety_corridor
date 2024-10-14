option(OPT_MESSAGE_LIB "" ON)

set (VENDOR_PREFIX ${CMAKE_SOURCE_DIR}/vendor)

vendor_add(SPDLOG)
vendor_add(OPENCV)
vendor_add(EIGEN)
vendor_add(JSON)
