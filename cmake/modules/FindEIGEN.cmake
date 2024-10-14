#  Try to find EIGEN lib
#  The following are set after configuration is done:
#  EIGEN_FOUND
#  EIGEN_INCLUDE_DIR
#  EIGEN_LIBRARY_DIR
#  EIGEN_LIBRARIES

set(EIGEN_INCLUDE_DIR "")
set(EIGEN_LIBRARY_DIR "")
set(EIGEN_LIBRARIES "")

# Find package
set(EIGEN_PATH ${VENDOR_PREFIX}/eigen)
find_file(EIGEN_FOUND "eigen3/Eigen/Core" PATHS ${EIGEN_PATH}/include)
if (EIGEN_FOUND)
    list(APPEND EIGEN_INCLUDE_DIR
        ${EIGEN_PATH}/include
        ${EIGEN_PATH}/include/eigen3
    )
else (EIGEN_FOUND)
    message(FATAL_ERROR "=====\EIGEN not found! Please install EIGEN first.\n")
endif(EIGEN_FOUND)



