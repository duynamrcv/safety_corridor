# -------
# Message
# -------

#### message
if(NOT WIN32)
  string(ASCII 27 Esc)
  set(ColourReset "${Esc}[m")
  set(ColourBold  "${Esc}[1m")
  set(Red         "${Esc}[31m")
  set(Green       "${Esc}[32m")
  set(Yellow      "${Esc}[33m")
  set(Blue        "${Esc}[34m")
  set(Magenta     "${Esc}[35m")
  set(Cyan        "${Esc}[36m")
  set(White       "${Esc}[37m")
  set(BoldRed     "${Esc}[1;31m")
  set(BoldGreen   "${Esc}[1;32m")
  set(BoldYellow  "${Esc}[1;33m")
  set(BoldBlue    "${Esc}[1;34m")
  set(BoldMagenta "${Esc}[1;35m")
  set(BoldCyan    "${Esc}[1;36m")
  set(BoldWhite   "${Esc}[1;37m")
endif()

#### Print variable
function(print var)
    message("${Blue}${var}: ${${var}}")
endfunction()


#### message
macro(print_title string)
    message(${White})
    message(STATUS ${White} ${string})
    message(${White})
endmacro()

#### message
macro(print_dir var string)
    message(${Yellow} "   " ${var} ${Green} ${ColourReset})
    foreach(library_dir ${string})
        message(${Yellow} "    -->" ${Green} "   " ${library_dir} ${ColourReset})
    endforeach()
endmacro()

#### message
macro(print_cmake_modules var string)
    message(${Yellow} "   " ${var} ${Green} ${ColourReset})
    foreach(library_dir ${string})
        message(${Yellow} "    -->" ${Green} "   " ${library_dir} ${ColourReset})
    endforeach()
endmacro()

#### message
macro(print_var string)
    message(${Yellow} "   " ${string} ${ColourReset})
endmacro()

#### message
macro(print_option option)
    if (${option})
         message(${Yellow} "   " "[${option}]" " = ${BoldRed} ON" ${ColourReset})
    else(${option})
         message(${Yellow} "   " "[${option}]" " = ${BoldBlue} OFF" ${ColourReset})
    endif(${option})
endmacro()

#### message
macro(print_build_type string option)
    if (${option} STREQUAL "Release")
         message(${Yellow} "   " ${string} " = ${BoldRed} Release" ${ColourReset})
    else ()
         message(${Yellow} "   " ${string} " = ${BoldBlue} Debug" ${ColourReset})
    endif()
endmacro()

#### message
macro(print_lib string)
    if (OPT_MESSAGE_LIB)
        message(${BoldBlue} "   " ${string} " : "  ${ColourReset})
        message(${BoldBlue} "   " "--------------------------------------"  ${ColourReset})
        print_dir("[${string}_INCLUDE_DIR]" "${${string}_INCLUDE_DIR}")
        print_dir("[${string}_LIBRARY_DIR]" "${${string}_LIBRARY_DIR}")
        print_dir("[${string}_LIBRARIES]" "${${string}_LIBRARIES}")
        message(" ")
    endif()
endmacro()

#### message
macro(print_libraries string include_dir include_lib lib)
    message(${BoldBlue} "   " ${string} " : "  ${ColourReset})
    message(${BoldBlue} "   " "--------------------------------------"  ${ColourReset})
    print_dir("[_${string}_INCLUDE_DIR_]" "${include_dir}")
    print_dir("[_${string}_LIBRARY_DIR_]" "${include_lib}")
    print_dir("[_${string}_LIBRARIES_]" "${lib}")
    message(" ")
endmacro()
