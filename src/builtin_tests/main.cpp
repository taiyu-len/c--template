#include "doctest/wrapper.h"
#include <iostream>
int main(int argc, char **argv) {
	printf("the real main gets called after tests (if they pass)\n");
	return EXIT_SUCCESS;
}

TEST_CASE("builtin test cases") {
	SUBCASE("always passes") {
		CHECK(2+2 == 4);
	}
}
