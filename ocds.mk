#!/usr/bin/make -f
# Copyright 2015 Al Nikolov

WORK_DIR=work
PROCS_DIR=process
DOCS=$(shell find $(WORK_DIR) -name *.xml)

.PHONY: ocds-procs ocds-docs

ocds-procs: $(DOCS:%.xml=%.stamp)
%.stamp: %.ocds process.xslt
	echo $$(xsltproc process.xslt $<) | \
		( read ocid id date && \
		  mkdir -p $(PROCS_DIR)/$$ocid && \
		  cp $< $(PROCS_DIR)/$$ocid/$$id.xml && \
		  touch -d $$date $(PROCS_DIR)/$$ocid/$$id.xml \
		)
	touch $@

ocds-docs: $(DOCS:%.xml=%.ocds)
%.ocds: %.xml ocds.xslt
	xsltproc -o $@ ocds.xslt $<
