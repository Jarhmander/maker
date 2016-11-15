####################################################################################################
#
# makevars.mk: once included, create vars from make/vars/*
#
# requires: readfile
#
####################################################################################################

include $(dir $(lastword ${MAKEFILE_LIST}))readfile.mk

$(foreach var,$(wildcard make/vars/*),$(eval $(notdir ${var}) := $(call readfile,${var})))

# default variables, can be overriden
OBJDIR := .obj

#
generate_rules_list ?=
handled_extensions ?=

define generate_rules_imp =
    $(eval ${generate_rules_list})
    unhandled_files := $$(filter-out ${handled_extensions},${SRC})
    $$(if $${unhandled_files},\
        $$(warning Unhandled files in SRC: $${unhandled_files})\
    )
endef

define generate_rules =
    $(eval ${generate_rules_imp})
endef
