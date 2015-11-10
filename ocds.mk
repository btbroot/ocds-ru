#!/usr/bin/make -f
# Copyright 2015 Al Nikolov

WORK_DIR=work
PROCS_DIR=process
PHASE1=-name fcsNotification*.xml 
PHASE1+=-o -name fcsPurchaseDocs*.xml
PHASE1+=-o -name contract_*.xml
PHASE2=! \( $(PHASE1) \)
DOCS=$(shell find $(WORK_DIR) $(PHASE1))
DOCS+=$(shell find $(WORK_DIR) $(PHASE2))

.PHONY: ocds-procs ocds-docs clean

ocds-procs: $(DOCS:%.xml=%.stamp)
%.stamp: %.ocds process.xslt
	echo $$(xsltproc process.xslt $<) | \
		( read ocid id date && \
		  echo ocid:$$ocid id:$$id date:$$date && \
		  if [ -n "$$ocid" -a -n "$$id" -a -n "$$date" ]; then \
			mkdir -p $(PROCS_DIR)/$$ocid && \
			cp $< $(PROCS_DIR)/$$ocid/$$id.xml && \
			touch -d $$date $(PROCS_DIR)/$$ocid/$$id.xml; \
		  else \
		  	echo Unable to process && \
		  	exit 1; \
		  fi \
		)
	touch $@

ocds-docs: $(DOCS:%.xml=%.ocds)
%.ocds: %.xml ocds.xslt
	xsltproc -o $@ ocds.xslt $<

clean:
	find $(WORK_DIR) -name *.ocds -delete
