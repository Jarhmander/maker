#
# Link line
#

define generate_rules_list +=

$${TARGET} : $${OBJS}
	$$(strip $${LD} -o $$@ $${LDFLAGS} $${COMMON_OPTS} $$(filter %.o,$$^)\
        $$(addprefix -L,$${LIBPATH}) $$(addprefix -l,$${LDLIBS}))
endef

