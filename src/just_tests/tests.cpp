#include <doctest.h>
#include <cstdlib>
#include <time.h>
TEST_CASE("test cases") {
	SUBCASE("passing inner") {
		CHECK(2+2 == 4);
	}
	SUBCASE("failing inner") {
		srand(time(nullptr));
		CHECK(2+2 == 4+ rand()%2);
	}
}
