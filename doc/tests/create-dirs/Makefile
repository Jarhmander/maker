####################################################################################################
# This example 'builds' some files and create, if necessary, all directory components.
OBJS :=
OBJS += \
		objs/foo.o \
		objs/src/bar.o \
		objs/src/fred.o \
		objs/src/hardware/spi.o \
		objs/goo.o \
		objs/src/hardware/can.o \
		objs/lib/spam.o \
		objs/lib/egg.o

####################################################################################################
# Basic rules

all: ${OBJS}
	@echo Done

# Here I try something unrelated, the $(file) function
clean:
	$(file >clean.in,${OBJS})
	xargs rm -f < clean.in
	rm -r objs clean.in

.PHONY: all clean
####################################################################################################

# String equality.
seq = $(and $(findstring $1,$2),$(findstring $2,$1))

# The dir function without the trailing slash
dir_stripped_slash = $(patsubst %/,%,$(dir $1))

# From a directory, enumerate all parent directories.
define make_dir_list
${1}$(if $(call seq,./,$(dir $1)),, $(call make_dir_list,$(call dir_stripped_slash,$1)))
endef

# Function that creates build rules on the fly. Note that we use sleep; this is to simulate a "long"
# build and better see how Make schedules the operations.
define gen_build_rule

${1} : | $(call dir_stripped_slash,$1)
	touch $$@
	@sleep 1

out_dir_list += $$(call make_dir_list,$$(call dir_stripped_slash,$1))
endef

# This simple rule handles dependencies between directories and their parents.
define gen_mkdir_rule
${1} : | $$(call dir_stripped_slash,${1})
	mkdir $$@

endef
####################################################################################################

# Create an empty "list"
out_dir_list :=

# Evaluate all file creation rules
$(foreach f,${OBJS}, \
    $(eval $(call gen_build_rule,$f)))

# Clean the directory list, removing all duplicates. This is a side-effect of $(sort).
out_dir_list := $(sort $(strip ${out_dir_list}))

# Finally, evaluate all directory creation rules.
$(foreach d,${out_dir_list},$(eval $(call gen_mkdir_rule,$d)))

