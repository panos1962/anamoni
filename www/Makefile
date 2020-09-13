#!/usr/bin/env make -f

###############################################################################@
#
# @BEGIN
#
# @COPYRIGHT BEGIN
# Copyright (C) 2020 Panos I. Papadopoulos <panos1962_AT_gmail_DOT_com>
# @COPYRIGHT END
#
# @FILETYPE BEGIN
# makefile
# @FILETYPE END
#
# @FILE BEGIN
# www/Makefile —— makefile αρχικής σελίδας εφαρμογής "anamoni"
# @FILE END
#
# @HISTORY BEGIN
# Created: 2020-09-12
# @HISTORY END
#
# @END
#
###############################################################################@

PANDORA_DIR = ../mnt/pandora

BUNDLE_JS = bundle.js
PARAGOGA = $(BUNDLE_JS)

BROWSERIFY_OPTS = -t envify -p tinyify
BROWSERIFY_OPTS = -t envify

.PHONY: all
all: $(PARAGOGA)

$(BUNDLE_JS): \
	$(PANDORA_DIR)/lib/pandoraCore.js \
	$(PANDORA_DIR)/lib/pandoraClient.js \
	main.js \
	../lib/anamoniClient.js \
	../lib/anamoniCore.js
	browserify $(BROWSERIFY_OPTS) -o $@ main.js

.PHONY: cleanup
cleanup:
	@rm -f $(PARAGOGA)
