## Included by CMakeLists
if(Options_CPU_cmake_included)
    return()
endif()
set(Options_CPU_cmake_included true)

# The options to build cpu
include(CMakeDependentOption)

option(USE_SYSTEM_LIBXSMM "Use system LIBXSMM library" OFF)
option(USE_SYSTEM_ONEDNN "Use system oneDNN library" OFF)
option(USE_SYSTEM_SLEEF "Use system SLEEF library" OFF)
option(USE_SYSTEM_MKL "Use system MKL library" OFF)
option(USE_SYSTEM_IDEEP "Use system ideep library" OFF)
option(USE_SYSTEM_GTEST "Use system GoogleTest library" OFF)

option(BUILD_LIBXSMM_VIA_CMAKE "Build LIBXSMM via CMake" ON)
option(USE_LIBXSMM "Enable LIBXSMM" ON)
option(USE_DNNL_GRAPH_COMPILER  "Build with DNNL Graph Compiler" ON)
if(WIN32)
  set(USE_LIBXSMM ON)
endif()

if(WIN32)
  set(USE_SHM OFF)
  set(BUILD_CPU_WITH_ONECCL OFF)
endif()

if(BUILD_CFG_HABANA)
  set(USE_DNNL_GRAPH_COMPILER OFF)
endif()

function (print_cpu_config_summary)
  # Fetch configurations of intel-ext-pt-cpu
  get_target_property(CPU_NATIVE_DEFINITIONS intel-ext-pt-cpu COMPILE_DEFINITIONS)
  get_target_property(ONEDNN_INCLUDE_DIR intel-ext-pt-cpu ONEDNN_INCLUDE_DIR)
  get_target_property(ONEMKL_INCLUDE_DIR intel-ext-pt-cpu ONEMKL_INCLUDE_DIR)
  get_target_property(CPU_LINK_LIBRARIES intel-ext-pt-cpu LINK_LIBRARIES)

    print_config_summary()
    message(STATUS "******** Summary on CPU ********")
    message(STATUS "General:")

    message(STATUS "  C compiler            : ${CMAKE_C_COMPILER}")

    message(STATUS "  C++ compiler          : ${CMAKE_CXX_COMPILER}")
    message(STATUS "  C++ compiler ID       : ${CMAKE_CXX_COMPILER_ID}")
    message(STATUS "  C++ compiler version  : ${CMAKE_CXX_COMPILER_VERSION}")

    message(STATUS "  CXX standard          : ${CMAKE_CXX_STANDARD}")
    message(STATUS "  CXX flags             : ${CMAKE_CXX_FLAGS}")
    message(STATUS "  Compile definitions   : ${CPU_NATIVE_DEFINITIONS}")
    message(STATUS "  CXX Linker options    : ${CMAKE_SHARED_LINKER_FLAGS}")
    message(STATUS "  Link libraries        : ${CPU_LINK_LIBRARIES}")

    message(STATUS "  Torch version         : ${Torch_VERSION}")
    message(STATUS "  Torch include         : ${TORCH_INCLUDE_DIRS}")

    message(STATUS "  oneDNN include        : ${ONEDNN_INCLUDE_DIR}")
    message(STATUS "  oneMKL include        : ${ONEMKL_INCLUDE_DIR}")

    message(STATUS "Options:")
    message(STATUS "  BUILD_STATIC_ONEMKL     : ${BUILD_STATIC_ONEMKL}")
    message(STATUS "  IPEX_DISP_OP            : ${IPEX_DISP_OP}")
    message(STATUS "  BUILD_XSMM_VIA_CMAKE    : ${BUILD_LIBXSMM_VIA_CMAKE}")
    message(STATUS "  USE_LIBXSMM             : ${USE_LIBXSMM}")
    message(STATUS "  USE_DNNL_GRAPH_COMPILER : ${USE_DNNL_GRAPH_COMPILER}")
    message(STATUS "  BUILD_CPU_WITH_ONECCL   : ${BUILD_CPU_WITH_ONECCL}")
    message(STATUS "  USE_SHM                 : ${USE_SHM}")
    message(STATUS "")
    message(STATUS "********************************")
endfunction()
