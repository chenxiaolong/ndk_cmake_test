cmake_minimum_required(VERSION 3.1)

project(test)

add_executable(main main.cpp)

if(NOT MSVC)
    set_target_properties(
        main
        PROPERTIES
        CXX_STANDARD 11
        CXX_STANDARD_REQUIRED 1
    )
endif()
