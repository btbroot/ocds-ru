#!/usr/bin/make -f
# Copyright 2015 Al Nikolov
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
