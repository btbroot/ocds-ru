# Copyright 2015 Al Nikolov
# curlftpfs -ouser=free:free ftp.zakupki.gov.ru mirror

SRC_DIR=mirror/fcs_regions/Adygeja_Resp
WORK_DIR=work

SRC_SCOPE =! -wholename */plangraphs/*
SRC_SCOPE+=! -wholename */protocols/*
SRC_SCOPE+=! -wholename */purchasedocs/*
SRC_SCOPE+=! -wholename */sketchplans/*
SRC_SCOPE+=! -wholename */prevMonth/*
SOURCES=$$(shell find $(SRC_DIR) $(SRC_SCOPE) -name *.zip)

ZIPSTAMPS=$(addprefix $(WORK_DIR)/,$(addsuffix .stamp,$(SOURCES)))

ZIP_EXCLUDES=-x tenderPlanUnstructured_*

DOCS=$(shell find $(WORK_DIR) -name *.xml -printf '%T@:%p\n' | sort | cut -d: -f2)
PRERELEASES=$(addsuffix .prerelease,$(basename $(DOCS)))

.PHONY: docs prereleases

prereleases: $(PRERELEASES)

%.prerelease: %.xml
	xsltproc -o $@ prerelease.xslt $<

docs: $(ZIPSTAMPS)

$(WORK_DIR)/%.zip.stamp: %.zip
	mkdir -p $(WORK_DIR)/$<
	unzip -o $< -d $(WORK_DIR)/$< $(ZIP_EXCLUDES) *.xml || [ $$? -eq 1 -o $$? -eq 11 ]
	$(file >$@,)


