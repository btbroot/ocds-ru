#!/usr/bin/make
# Copyright 2015 Al Nikolov
# curlftpfs -ouser=free:free ftp.zakupki.gov.ru mirror

SRC_DIR=mirror/fcs_regions/Adygeja_Resp
WORK_DIR=work

SRC_SCOPE =! -wholename */plangraphs/*
SRC_SCOPE+=! -wholename */sketchplans/*
SRC_SCOPE+=! -wholename */prevMonth/*
SOURCES=$(shell find $(SRC_DIR) $(SRC_SCOPE) -name *.zip)
ZIPSTAMPS=$(addprefix $(WORK_DIR)/,$(addsuffix .stamp,$(SOURCES)))
ZIP_EXCLUDES=-x tenderPlanUnstructured_*.xml

.PHONY: docs

docs: $(ZIPSTAMPS)
$(WORK_DIR)/%.zip.stamp: %.zip
	mkdir -p $(WORK_DIR)/$<
	unzip -o $< *.xml $(ZIP_EXCLUDES) -d $(WORK_DIR)/$< || \
		[ $$? -eq 1 -o $$? -eq 11 ]
	touch $@
