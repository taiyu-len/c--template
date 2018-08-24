-include targets.mk    # Userdefined Targets.
-include buildflags.mk # Userdefined Build Flags
.LIBPATTERNS:=
.PHONY: all clean cleanall
.SECONDARY: $(static:%=-l%) $(shared:%=-l%) $(shared) $(static)
all: $(target)

sources != find src     -regextype awk -regex '.*\.(c|cc|cpp)'
headers != find include -regextype awk -regex '.*\.(h|hh|hpp)'
objects := $(addsuffix .o,$(basename $(sources)))
depends := $(addsuffix .mk,$(basename $(sources)))
compdb  := $(addsuffix .compdb,$(sources) $(headers))
PATTERN := %
LDFLAGS += -L $(realpath .)
CPPFLAGS += -Iinclude

# Generate Dependencies
-include $(depends)
%.mk: %.c;   @$(CC)  $(CPPFLAGS) $< -MM -MT $*.o -MT $@ > $@
%.mk: %.cc;  @$(CXX) $(CPPFLAGS) $< -MM -MT $*.o -MT $@ > $@
%.mk: %.cpp; @$(CXX) $(CPPFLAGS) $< -MM -MT $*.o -MT $@ > $@

# Generate compile_commands.json
-include compdb.mk
compile_commands.json: $(compdb)

# Depend on buildflags
$(objects) $(compdb): buildflags.mk

# Build Instructions
.SECONDEXPANSION:
$(target): $$(filter src/$$@/%,$(objects))
	$(LINK.o) $^ $(LDLIBS) -o $@

# Library Dependency Chain
-l%: lib%.so;
-l%: lib%.a;

$(shared:%=lib%.so): lib%.so: $$*;
$(static:%=lib%.a) : lib%.a : $$*;

$(shared): CXXFLAGS += -fPIC
$(shared): $$(filter src/$$@/%,$(objects))
	$(LINK.o) -shared -Wl,-soname,lib$@.so $^ $(LDLIBS) -o lib$@.so
$(static): $$(filter src/$$@/%,$(objects))
	$(AR) $(ARFLAGS) lib$@.a $?

clean:
	@rm -f $(objects) $(depends) $(target) $(shared:%=lib%.so) $(static:%=lib%.a)
cleanall: clean
	@rm -f $(compdb) compile_commands.json

