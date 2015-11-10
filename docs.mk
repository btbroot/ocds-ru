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
#    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
#
# curlftpfs -ouser=free:free ftp.zakupki.gov.ru mirror

SRC_DIR=mirror/fcs_regions/Adygeja_Resp
WORK_DIR=work

SRC_SCOPE =! -wholename */plangraphs/*
SRC_SCOPE+=! -wholename */sketchplans/*
SRC_SCOPE+=! -wholename */prevMonth/*
SOURCES=$(shell find $(SRC_DIR) $(SRC_SCOPE) -name *.zip)
ZIP_EXCLUDES=-x tenderPlanUnstructured_*.xml

.PHONY: docs
docs: $(addprefix $(WORK_DIR)/,$(SOURCES:%.zip=%.stamp))
$(WORK_DIR)/%.stamp: %.zip
	mkdir -p $(WORK_DIR)/$<
	unzip -o $< *.xml $(ZIP_EXCLUDES) -d $(WORK_DIR)/$< || \
		[ $$? -eq 1 -o $$? -eq 11 ]
	touch $@
