target:= solo foo just_tests builtin_tests
shared:= bar
static:= baz doctest doctest_wrapper

######## test executables
tested:= just_tests builtin_tests
TEST_FLAGS:= --dt-exit --dt-no-version
test_builtin_tests: TEST_FLAGS+= --foo
