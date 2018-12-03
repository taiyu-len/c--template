CXX      := clang++
LINK.o    = $(LINK.cc)
override CXXFLAGS += -std=c++17 -Wall -march=native

DEBUG ?= 1
ifeq ($(DEBUG), 1)
  override CXXFLAGS += -g1 -fsanitize=address,undefined
else
  override CPPFLAGS += -DNDEBUG
endif
