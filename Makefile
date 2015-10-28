# Copyright 2015 Al Nikolov
# curlftpfs -ouser=free:free ftp.zakupki.gov.ru mirror

SRC_DIR=mirror/fcs_regions/Adygeja_Resp/
WORK_DIR=work

SRC_SCOPE =! -wholename */plangraphs/*
SRC_SCOPE+=! -wholename */protocols/*
SRC_SCOPE+=! -wholename */purchasedocs/*
SRC_SCOPE+=! -wholename */sketchplans/*
SRC_SCOPE+=! -wholename */prevMonth/*
SOURCES=$(shell find $(SRC_DIR) $(SRC_SCOPE) -name *.zip)
ZIPSTAMPS=$(addprefix $(WORK_DIR)/,$(addsuffix .stamp,$(SOURCES)))
ZIP_EXCLUDES=-x tenderPlanUnstructured_*

.PHONY: unzip

unzip: $(ZIPSTAMPS)

$(WORK_DIR)/%.zip.stamp: %.zip
	mkdir -p $(WORK_DIR)/$<
	unzip -jn $< -d $(WORK_DIR)/$< $(ZIP_EXCLUDES)|| [ $$? -eq 1 -o $$? -eq 11 ]
	touch $@


