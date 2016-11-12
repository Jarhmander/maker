#
# Set depedencies
#


# All files (except SRC) are optional. Mark them as such (empty recipe).
make/vars/LDFLAGS: ;
make/vars/LIBFLAGS: ;
make/vars/COMMON_OPTS: ;
make/vars/CFLAGS: ;
make/vars/CXXFLAGS: ;
make/vars/ASFLAGS: ;
make/vars/INCPATH: ;
make/vars/DEFINES: ;

# Relink when those variables changes
# NOTE: Only depend on file that actually exist, otherwise everythin is rebuilt each time
$${TARGET} : make/vars/SRC $$(wildcard make/vars/LIBFLAGS make/vars/LDFLAGS)

# Rebuild when those variables changes
$${OBJS} : $$(wildcard make/vars/COMMON_OPTS make/vars/CFLAGS make/vars/CXXFLAGS make/vars/ASFLAGS)
$${OBJS} : $$(wildcard make/vars/INCPATH make/vars/DEFINES)

# Any changes to the Makefile and the helpers can have a serious impact and all must be rebuilt
$${OBJS} : Makefile $$(wildard make/helpers/H_*.mk)

