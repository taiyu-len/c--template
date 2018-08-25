#include "tested/prog.hpp"
#include <iostream>

int real_main(int argc, char **argv) {
	for (int i = 0; i < argc; ++i) {
		printf("%d: %s\n", i, argv[i]);
	}
	printf("prog() = %d\n", prog());
	return 0;
}
