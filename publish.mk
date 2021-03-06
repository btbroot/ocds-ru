#!/usr/bin/make -f
#
# Copyright 2015 Al Nikolov
#
# This file is part of ocds-ru suite.
#
#    ocds-ru is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    ocds-ru is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with ocds-ru.  If not, see <http://www.gnu.org/licenses/>.
#

PROCS_DIR=ocds-procs
PROCS=$(shell find $(PROCS_DIR) -mindepth 1 -type d)
RECORDPACKS=$(addsuffix .json,$(PROCS))
SORTED_RELEASES=$(shell find $(basename $@) -name \*.xml -printf '%T@\t%p\n' | sort | cut -f2)

.PHONY: all clean
all: $(RECORDPACKS)
$(RECORDPACKS):
	xsltproc -o $@.xml-tmp \
		--stringparam ocid $(notdir $(basename $@)) \
		--stringparam releases "$(SORTED_RELEASES)" record-package.xml
	xsltproc -o $@.tmp xml2json.xslt $@.xml-tmp
	./schema-validator.py ocds-schema/record-package-schema.json < $@.tmp
	rm -f $@.xml-tmp
	mv $@.tmp $@
clean:

