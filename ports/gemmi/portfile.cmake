vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO project-gemmi/gemmi
  REF 32ed5769405f4f76ea1404d12bf9e8ba63113b8f
  SHA512 578c8c08eaa8a27922b526c42b92797b5f12ab5e2e368a7f9e9f5e73840d3a428d445e382a925311114404c0f751087204dededed2eaef224e847b50ee23adc5
)

vcpkg_configure_cmake(
  SOURCE_PATH "${SOURCE_PATH}"
#   PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(
    PACKAGE_NAME "gemmi"          # if the project name (glfw3) is different from the port name (glfw)
    CONFIG_PATH "lib/cmake/gemmi" # where to find project's CMake configs
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(
  INSTALL "${SOURCE_PATH}/LICENSE.txt"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)