target_include_directories(geo PRIVATE "${PROJECT_SOURCE_DIR}")
add_subdirectory("shape")
add_subdirectory("square")

install(
    TARGETS geo
    EXPORT geoTargets
    FILE_SET HEADERS
    LIBRARY
    DESTINATION lib
    ARCHIVE
    DESTINATION lib
    RUNTIME
    DESTINATION bin
    INCLUDES DESTINATION include
)

