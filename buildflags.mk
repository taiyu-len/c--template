# default build flags and pertarget build flags.
CXX      := clang++
CXXFLAGS := -g1 -std=c++17 -fsanitize=address,undefined
# Required to use proper linker when compiling c++ code.
LINK.o    = $(LINK.cc)


