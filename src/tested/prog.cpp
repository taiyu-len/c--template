#include "tested/prog.hpp"
#include <doctest.h>
int prog() {
	/* does magic */
	return 42;
}

TEST_CASE("test prog()") {
	CHECK(prog() == 42);
}
