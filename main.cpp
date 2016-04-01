#include <string>

#include <cstdio>
#include <cstdlib>

int main(int argc, char *argv[])
{
    std::string blah("Hello world!");
    std::printf("%s\n", blah.c_str());
    return EXIT_SUCCESS;
}
