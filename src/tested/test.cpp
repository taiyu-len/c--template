#define DOCTEST_CONFIG_NO_UNPREFIXED_OPTIONS
#define DOCTEST_CONFIG_IMPLEMENT
#include <doctest.h>
#include <algorithm>
#include <cstring>

int real_main(int argc, char **argv);
int main(int argc, char**argv) {
	auto context = doctest::Context(argc, argv);
	auto result = context.run();
	if (result || context.shouldExit()) {
		return result;
	}
	// Filter out doctest arguments.
	auto is_doctest_arg = [](const char *s) {
		return strncmp(s, "--dt-", strlen("--dt-")) == 0;
	};
	char **last_arg = std::remove_if(argv, argv+argc, is_doctest_arg);
	*last_arg = nullptr;

	// Call real main with remaining arguments
	return real_main(last_arg - argv, argv);
}

