# ./
# ./include/...      # Public includes. -Iinclude flag is set for compiling
# ./src/$target/...  # Per target source files. 
#### TODO add more later

# List of targets within src directory, and what kind of target it is.
######## executable targets
target:= solo foo tested

######## shared libraries. (libfoo.so)
shared:= bar

######## static libraries. (libfoo.a)
static:= baz


# solo, standalone target.
# foo, bar, baz. target depending on shared and static library
# tested. standalone with doctest integrated

# TODO other configurations
