# Copyright 2015 Al Nikolov

SRC_HOST=ftp.zakupki.gov.ru
MIRROR_DIR=mirror
WORK_DIR=work
VPATH=$(shell find $(MIRROR_DIR) -type d)
ZIPS=$(shell find $(MIRROR_DIR) -name *.zip)
STAMPS=$(addprefix $(WORK_DIR)/,$(addsuffix .stamp,$(notdir $(ZIPS))))

mirror-update:
	lftp $(SRC_HOST) -u free,free -e 'mirror fcs_regions/Moskva $(MIRROR_DIR)/fcs_regions/ -c -P5 -e --no-empty-dirs -X PrevMonth/'

unzip-all: $(STAMPS)

$(WORK_DIR)/%.stamp: %
	unzip -j -n $< -d $(WORK_DIR) || test $$? -eq 1
	touch $@

.PHONY: mirror-update unzip-all
