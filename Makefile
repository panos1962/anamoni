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
# Makefile —— Κεντρικό makefile εφαρμογής "anamoni"
# @FILE END
#
# @HISTORY BEGIN
# Created: 2020-09-12
# @HISTORY END
#
# @END
#
###############################################################################@

.SILENT:

.PHONY: all
all:
	(cd www && make)

test:
	make all
	bash local/test.sh

# GIT SECTION

.PHONY: status
status:
	git status .

.PHONY: diff
diff:
	git diff .

.PHONY: show
show:
	git add --dry-run .

.PHONY: add
add:
	git add --verbose .

.PHONY: commit
commit:
	git commit --message "modifications" .; :

.PHONY: push
push:
	git push

.PHONY: git
git:
	-git commit --message "modifications" .
	make push
	echo "###################################"
	make status

.PHONY: pull
pull:
	git pull

# FILE SECTION

.PHONY: cleanup
cleanup:
	@(cd www && make cleanup)
