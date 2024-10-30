#include <hello.hpp>

namespace hello {

    std::string_view get_hello() noexcept {
        return "Hello World!";
    }

}// namespace hello
