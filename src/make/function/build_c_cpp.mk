####################################################################################################
#
# build_c_cpp.mk: define how to build C and C++ files
#
####################################################################################################

####################################################################################################
# build_common: generate rules to build .c and .cpp file
#
# args:
#   1: file to build
#   2: destination file
#   3: compiler
#   4: compiler specific flags
# result:
#   string to be EVALuated
####################################################################################################
define build_common =

.PHONY: ${1}.build

OBJS += ${2}

${1}.build ${2} : ${1}
	@mkdir -p $(dir ${2});
	$$(strip ${3} -c -o ${2} $${COMMON_OPTS} ${4} $$(addprefix -I,$${INCPATH}) $$(addprefix -D,$${DEFINES}) -MP -MD -MF ${2:.o=.d} ${1})
-include ${2:.o=.d}

endef
####################################################################################################

build_c_cpp_ext := cc C cxx cpp c++ cp CPP

define generate_rules_list +=

$(foreach src,$(strip $(filter %.c,${SRC})),$(eval $(call build_common,${src},${OBJDIR}/${src:.c=.o},${CC},${CFLAGS})))
$(foreach cxxext,${build_c_cpp_ext},\
   $(foreach src,$(strip $(filter %.${cxxext},${SRC})),\
      $(eval $(call build_common,${src},${OBJDIR}/${src:.${cxxext}=.o},${CXX},${CXXFLAGS}))))
endef

handled_extensions += %.c $(addprefix %.,${build_c_cpp_ext})

