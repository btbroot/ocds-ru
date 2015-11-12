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

WORK_DIR=work
export PROCS_DIR=ocds-procs
PHASE1=-name fcsNotification*.xml 
PHASE1+=-o -name fcsPurchaseDocs*.xml
PHASE1+=-o -name contract_*.xml
PHASE2=! \( $(PHASE1) \)
DOCS=$(shell find $(WORK_DIR) $(PHASE1))
DOCS+=$(shell find $(WORK_DIR) $(PHASE2))

.PHONY: all clean

all: $(DOCS:%.xml=%.stamp)
%.stamp: %.ocds process.xslt process; ./process $< $@
%.ocds: %.xml ocds.xslt; xsltproc -o $@ ocds.xslt $<
clean:; find $(WORK_DIR) -name *.stamp -delete
