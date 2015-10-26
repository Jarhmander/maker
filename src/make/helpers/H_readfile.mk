#
# readfile: read and process content of file, stripping comments (#) and empty lines
#
# args:
#   1: filename
#
# result:
#   Processed content of file without comments or empty lines.
#

define readfile =
   $(shell sed -e 's/#.*//' -e '/^$$/d' ${1})
endef

