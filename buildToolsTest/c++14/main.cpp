// main.cpp
#include <memory>
#include <iostream>

int main( int argc, const char* argv[] )
{
    auto p = std::make_unique<int>(10);
    std::cout << *p.get() << std::endl;
    auto lmb = [p = std::move(p)] { return *p; };
    std::cout << lmb() << std::endl;
}

// EOF