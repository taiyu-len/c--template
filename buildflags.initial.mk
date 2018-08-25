CXX      := clang++
CXXFLAGS := -g1 -std=c++17 -fsanitize=address,undefined
LINK.o    = $(LINK.cc)
