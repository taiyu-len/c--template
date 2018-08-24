#include "foo/foo.hpp"
#include <iostream>
int main() {
	printf("%s\n", foo(true));
	printf("%s\n", foo(false));
}
const char* foo(bool cond) {
	return cond ? bar() : baz();
}

