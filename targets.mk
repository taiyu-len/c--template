# ./
# ./include/...      # Public includes. -Iinclude flag is set for compiling
# ./src/$target/...  # Per target source files. 
#
#### TODO add more later

# List of targets within src directory, and what kind of target it is.
######## executable targets
target:= solo foo

######## shared libraries. (libfoo.so)
shared:= bar

######## static libraries. (libfoo.a)
static:= baz

# TODO other configurations
