cmake_minimum_required(VERSION 3.21)
project(starter)
include(CTest)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)
set(CMAKE_CXX_EXTENSIONS FALSE)

set(CMAKE_INSTALL_RPATH $ORIGIN/../lib)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
set(CMAKE_CXX_COMPILER_LAUNCHER ccache)

set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fsanitize=address,undefined")
set(CMAKE_CXX_FLAGS_TSAN "${CMAKE_CXX_FLAGS_TSAN} -fsanitize=thread")

#set(CMAKE_CXX_CLANG_TIDY "clang-tidy;-checks=-*,bugprone-*,cert-dcl21-cpp,cert-dcl50-cpp,cert-env33-c,cert-err34-c,cert-err52-cpp,cert-err60-cpp,cert-flp30-c,cert-msc50-cpp,cert-msc51-cpp,cppcoreguidelines-*,-cppcoreguidelines-macro-usage,-cppcoreguidelines-pro-type-reinterpret-cast,-cppcoreguidelines-pro-type-union-access,-cppcoreguidelines-pro-bounds-pointer-arithmetic,-cppcoreguidelines-pro-type-vararg,google-build-using-namespace,google-explicit-constructor,google-global-names-in-headers,google-readability-casting,google-runtime-int,google-runtime-operator,hicpp-*,-hicpp-vararg,misc-*,modernize-*,performance-*,readability-*,-readability-named-parameter")

add_compile_options(-Wall -Wextra -Wpedantic -Werror)

find_package(Boost REQUIRED)
find_package(OpenSSL REQUIRED)

add_executable(server
    server_certificate.hpp
    server.cpp
)
target_compile_options(server PRIVATE -Wno-error=unused-parameter)
target_link_libraries(server
    OpenSSL::SSL OpenSSL::Crypto
)

install(TARGETS server)
install(IMPORTED_RUNTIME_ARTIFACTS server RUNTIME_DEPENDENCY_SET s)
install(RUNTIME_DEPENDENCY_SET s)
