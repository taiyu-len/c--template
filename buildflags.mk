CXX      := clang++
LINK.o    = $(LINK.cc) # Required for C++ programs
override CXXFLAGS += -std=c++17 -Wall -march=native

DEBUG ?= 1
ifeq ($(DEBUG), 1)
  override CXXFLAGS += -g1 -fsanitize=address,undefined
else
  override CPPFLAGS += -DNDEBUG -DDOCTEST_CONFIG_DISABLE
endif

# Depedencies between libraries is done like such
# Execute via LD_LIBRARY_PATH=.
foo: -lbar -lbaz
just_tests: -ldoctest
builtin_tests: -ldoctest_wrapper
