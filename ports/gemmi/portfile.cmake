# Download the source code from GitHub
vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO project-gemmi/gemmi                      # GitHub repository
  REF 32ed5769405f4f76ea1404d12bf9e8ba63113b8f  # Commit hash pointing to a version tag
  SHA512 578c8c08eaa8a27922b526c42b92797b5f12ab5e2e368a7f9e9f5e73840d3a428d445e382a925311114404c0f751087204dededed2eaef224e847b50ee23adc5
)

# Configure the project using CMake
vcpkg_configure_cmake(
  SOURCE_PATH "${SOURCE_PATH}"
  PREFER_NINJA
)

# Define variables for the .pc file
set(PACKAGE_NAME "gemmi")
set(PACKAGE_DESCRIPTION "Macromolecular crystallography library and utilities")
set(PACKAGE_VERSION "0.7.0")  # can this be extracted from the vcpkg.json file?

# Build and install the project
vcpkg_install_cmake()

# Generate the .pc file from template.pc.in
configure_file(
    ${CMAKE_CURRENT_LIST_DIR}/template.pc.in
    ${CURRENT_PACKAGES_DIR}/lib/pkgconfig/${PACKAGE_NAME}.pc
    @ONLY
)

# Install the .pc file to the final destination
file(INSTALL ${CURRENT_PACKAGES_DIR}/lib/pkgconfig/${PACKAGE_NAME}.pc
    DESTINATION ${CURRENT_INSTALLED_DIR}/lib/pkgconfig
)

# Fix up the pkgconfig file paths
vcpkg_fixup_pkgconfig()

# Move misplaced CMake files to the correct directory
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/cmake)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/cmake)

# Copy executables to the tools directory
vcpkg_copy_tools(
  TOOL_NAMES gemmi
  AUTO_CLEAN
)

# Install the license file
file(
  INSTALL "${SOURCE_PATH}/LICENSE.txt"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright
)
