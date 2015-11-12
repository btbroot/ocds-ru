#!/usr/bin/make -f
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
PROCS=$(shell find $(PROCS_DIR) -mindepth 1 -maxdepth 1 -type d)
RECORDS=$(PROCS:%=%/record.json)

.PHONY: all clean

all: $(RECORDS)
%.release.json: xml2json.xslt %.xml; xsltproc -o $@ $^
clean:
.SECONDEXPANSION:
$(RECORDS): %/record.json: $$(addsuffix .release.json,$$(basename $$(wildcard $$*/*.xml)))
	
