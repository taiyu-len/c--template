-include targets.mk    # Userdefined Targets.
-include buildflags.mk # Userdefined Build Flags
.LIBPATTERNS:=
.PHONY: all clean cleanall
.SECONDARY: $(static:%=-l%) $(shared:%=-l%) $(shared) $(static)
.DEFAULT_GOAL:=all
all: $(target)

SOURCES != find src     -regextype awk -regex '.*\.(c|cc|cpp)'
HEADERS != find include -regextype awk -regex '.*\.(h|hh|hpp)'
OBJECTS := $(addsuffix .o,$(basename $(SOURCES)))
DEPENDS := $(addsuffix .d,$(basename $(SOURCES)))
COMPDB  := $(addsuffix .compdb,$(SOURCES) $(HEADERS))
PATTERN := %
LDFLAGS += -L $(realpath .)
CPPFLAGS += -Iinclude

# Generate Dependencies
-include $(DEPENDS)
%.d: %.c;   @$(CC)  $(CPPFLAGS) $< -MM -MT $*.o -MT $@ > $@
%.d: %.cc;  @$(CXX) $(CPPFLAGS) $< -MM -MT $*.o -MT $@ > $@
%.d: %.cpp; @$(CXX) $(CPPFLAGS) $< -MM -MT $*.o -MT $@ > $@

# Generate compile_commands.json
-include compdb.mk
compile_commands.json: $(COMPDB)

# Depend on buildflags
$(objects) $(compdb): buildflags.mk

# Build Instructions
.SECONDEXPANSION:
$(target): $$(filter src/$$@/%,$(OBJECTS))
	$(LINK.o) $^ $(LDLIBS) -o $@

# Shared Library Dependency chain
-l%: lib%.so;
$(shared:%=lib%.so): lib%.so: $$*;
$(shared): CXXFLAGS += -fPIC
$(shared): $$(filter src/$$@/%,$(OBJECTS))
	$(LINK.o) -shared -Wl,-soname,lib$@.so $^ $(LDLIBS) -o lib$@.so
# Static Library Dependency chain
-l%: lib%.a;
$(static:%=lib%.a) : lib%.a : $$*;
$(static): $$(filter src/$$@/%,$(OBJECTS))
	$(AR) $(ARFLAGS) lib$@.a $?

clean:
	@rm -f $(OBJECTS) $(DEPENDS) $(target) $(shared:%=lib%.so) $(static:%=lib%.a)
cleanall: clean
	@rm -f $(COMPDB) compile_commands.json

