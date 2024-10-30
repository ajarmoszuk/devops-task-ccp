#include <hello.hpp>

#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>

using namespace std::string_literals;
using namespace std::string_view_literals;

template<typename T>
void assert_equal(const T& a, const T& b) {
    if (a != b) {
        std::stringstream ss;
        ss << "Assertion failed: '" << a << "' != '" << b << "'";
        throw std::logic_error(ss.str());
    }
}

void test_get_hello() {
    auto text = hello::get_hello();
    assert_equal(text, "Hello, World!"sv);
}

int main() {

    try {
        test_get_hello();
    } catch (const std::logic_error& ex) {
        std::cerr << "Tests failed: " << ex.what() << std::endl;
        return 1;
    }

    return 0;
}
