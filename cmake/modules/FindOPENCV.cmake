#  Try to find OPENCV lib
#  The following are set after configuration is done:
#  OPENCV_FOUND
#  OPENCV_INCLUDE_DIR
#  OPENCV_LIBRARY_DIR
#  OPENCV_LIBRARIES

set(OPENCV_INCLUDE_DIR "")
set(OPENCV_LIBRARY_DIR "")
set(OPENCV_LIBRARIES "")

# Find package
set(OPENCV_PATH ${VENDOR_PREFIX}/opencv)
find_file(OPENCV_FOUND "opencv2/opencv.hpp" PATHS ${OPENCV_PATH}/include)
if (OPENCV_FOUND)
    list(APPEND OPENCV_INCLUDE_DIR
        ${OPENCV_PATH}/include/opencv4
        ${OPENCV_PATH}/include
        ${OPENCV_INCLUDE_DIRS}
    )
    list(APPEND OPENCV_LIBRARY_DIR
        ${OPENCV_PATH}/lib
    )
    list(APPEND OPENCV_LIBRARIES
        opencv_calib3d
        opencv_core
        opencv_dnn
        opencv_features2d
        opencv_flann
        opencv_gapi
        opencv_highgui
        opencv_imgcodecs
        opencv_imgproc
        opencv_ml
        opencv_objdetect
        opencv_photo
        opencv_stitching
        opencv_video
        opencv_videoio
        opencv_aruco
        opencv_bgsegm
        opencv_bioinspired
        opencv_ccalib
        opencv_datasets
        opencv_dnn_objdetect
        opencv_dnn_superres
        opencv_dpm
        opencv_face
        opencv_fuzzy
        opencv_hfs
        opencv_img_hash
        opencv_intensity_transform
        opencv_line_descriptor
        opencv_optflow
        opencv_phase_unwrapping
        opencv_plot
        opencv_quality
        opencv_rapid
        opencv_reg
        opencv_rgbd
        opencv_saliency
        opencv_shape
        opencv_stereo
        opencv_structured_light
        opencv_superres
        opencv_surface_matching
        opencv_text
        opencv_tracking
        opencv_videostab
        opencv_xfeatures2d
        opencv_ximgproc
        opencv_xobjdetect
        opencv_xphoto
    )
else (OPENCV_FOUND)
    message(FATAL_ERROR "=====\OpenCV not found! Please install OPENCV first.\n")
endif(OPENCV_FOUND)


