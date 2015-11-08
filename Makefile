#!/usr/bin/make -f
# Copyright 2015 Al Nikolov
# curlftpfs -ouser=free:free ftp.zakupki.gov.ru mirror

WORK_DIR=work

DOCS=$(shell find $(WORK_DIR) -name *.xml -printf '%T@:%p\n' | sort | \
	cut -d: -f2)
PRERELEASES=$(addsuffix .prerelease,$(basename $(DOCS)))

.PHONY: prereleases

prereleases: $(PRERELEASES)
%.prerelease: %.xml prerelease.xslt
	xsltproc -o $@ prerelease.xslt $<
