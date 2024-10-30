add_library(hello_lib src/hello.cpp)

target_include_directories(hello_lib PUBLIC include PRIVATE src)

# Add test executable
add_executable(hello_tests tests/test_get_hello.cpp)
target_link_libraries(hello_tests PRIVATE hello_lib)

# Register the test
add_test(NAME hello_tests COMMAND hello_tests)
