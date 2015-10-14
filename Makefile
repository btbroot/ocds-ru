# Copyright 2015 Al Nikolov

SRC_HOST=ftp.zakupki.gov.ru

mirror-update:
	wget -m ftp://free:free@$(SRC_HOST)/fcs_regions/Adygeja_Resp/ --no-parent -A xml.zip 2>&1 | tee mirror-update.log
	cd $(SRC_HOST) && git add . && git commit -a -m mirror-update || true

.PHONY: mirror-update
