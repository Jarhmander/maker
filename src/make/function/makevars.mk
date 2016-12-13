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
    $$(if $$(strip $${TARGET}),,$$(warning TARGET not set; default to a.out)\
		$$(eval TARGET:=a.out))

    $$(if $$(strip $${SRC}),,$$(error SRC is empty; specify some source to build))

    $(eval ${generate_rules_list})
    unhandled_files := $$(filter-out ${handled_extensions},${SRC})
    $$(if $${unhandled_files},\
        $$(warning Unhandled files in SRC: $${unhandled_files})\
    )

endef

define generate_rules =
    $(eval ${generate_rules_imp})
endef
