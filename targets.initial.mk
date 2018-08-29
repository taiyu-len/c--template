# ./                 # Root directory, binaries placed here
# ./include/...      # Public includes. -Iinclude flag is set for compiling
# ./src/$target/...  # Per target source files. 
# List of executables to build
target:=
# List of shared libraries to build, builds with -fPIC flag
shared:=
# List of static libraries to build.
static:=
# List of executables from $(target) to test
tested:= # Target executable to run on `make test` 

# Flags used for all tests \
TEST_FLAGS := --dt-exit --dt-no-version
# Flags use per test target \
test_target-name: TEST_FLAGS += --foo
