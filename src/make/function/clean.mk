####################################################################################################
#
# clean.mk: generate clean rule
#
####################################################################################################

define generate_rules_list +=

.PHONY: clean
clean:
	rm -rf $${TARGET} $${OBJDIR}


endef
