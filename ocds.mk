#!/usr/bin/make -f
# Copyright 2015 Al Nikolov
# curlftpfs -ouser=free:free ftp.zakupki.gov.ru mirror

WORK_DIR=work
DOCS=$(shell find $(WORK_DIR) -name *.xml)

.PHONY: ocds-docs
ocds-docs: $(DOCS:%.xml=%.ocds)
%.ocds: %.xml prerelease.xslt
	xsltproc -o $@ prerelease.xslt $<
