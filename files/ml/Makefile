# -*- coding: utf-8 -*-
# SOURCE: https://github.com/autopilotpattern/jenkins/blob/master/makefile
MAKEFLAGS += --warn-undefined-variables
# .SHELLFLAGS := -eu -o pipefail

# SOURCE: https://github.com/luismayta/zsh-servers-functions/blob/b68f34e486d6c4a465703472e499b1c39fe4a26c/Makefile
# Configuration.
SHELL = /bin/bash
ROOT_DIR = $(shell pwd)
PROJECT_BIN_DIR = $(ROOT_DIR)/bin
DATA_DIR = $(ROOT_DIR)/var
SCRIPT_DIR = $(ROOT_DIR)/script

WGET = wget
# SOURCE: https://github.com/wk8838299/bullcoin/blob/8182e2f19c1f93c9578a2b66de6a9cce0506d1a7/LMN/src/makefile.osx
HAVE_BREW=$(shell brew --prefix >/dev/null 2>&1; echo $$? )


.PHONY: list help default all check fail-when-git-dirty

.PHONY: FORCE_MAKE

PR_SHA                := $(shell git rev-parse HEAD)

define ASCILOGO
universityofprofessorex-ml
=======================================
endef

export ASCILOGO

# http://misc.flogisoft.com/bash/tip_colors_and_formatting

RED=\033[0;31m
GREEN=\033[0;32m
ORNG=\033[38;5;214m
BLUE=\033[38;5;81m
NC=\033[0m

export RED
export GREEN
export NC
export ORNG
export BLUE

# verify that certain variables have been defined off the bat
check_defined = \
		$(foreach 1,$1,$(__check_defined))
__check_defined = \
		$(if $(value $1),, \
			$(error Undefined $1$(if $(value 2), ($(strip $2)))))

export PATH := ./script:./bin:./bash:./venv/bin:$(PATH)

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
CURRENT_FOLDER := $(notdir $(patsubst %/,%,$(dir $(MKFILE_PATH))))
CURRENT_DIR := $(shell pwd)
MAKE := make
PY_MODULE_NAME := universityofprofessorex-ml

list_allowed_args := product ip command role tier cluster non_root_user host

default: all

all: info

clean:
	find . -name '*.DS_Store' -exec rm -fv {} +
	find . -name '*.tar.gz' -exec rm -fv {} +
	find . -name '*.pyc' -exec rm -fv {} +
	find . -name '*.pyo' -exec rm -fv {} +
	find . -name '__pycache__' -exec rm -frv {} +
	rm -f .coverage
	find . | \
	grep -E "(__pycache__|\.pyc$|\.pyo$)" | \
	xargs rm -rf

#--- User Defined Variable ---
PACKAGE_NAME="universityofprofessorex-ml"

tar-ml-emotion: clean
	tar -cjvf $(ROOT_DIR)/emotion.tar.gz $(ROOT_DIR)/emotion/

tar-ml-human-activity-recognition: clean
	tar -cjvf $(ROOT_DIR)/human-activity-recognition.tar.gz $(ROOT_DIR)/human-activity-recognition/

tar-ml-humor: clean
	tar -cjvf $(ROOT_DIR)/humor.tar.gz $(ROOT_DIR)/humor/

tar-ml-nfsw-model: clean
	tar -cjvf $(ROOT_DIR)/nsfw-model.tar.gz $(ROOT_DIR)/nsfw-model/

tar-all: tar-ml-emotion tar-ml-human-activity-recognition tar-ml-humor tar-ml-nfsw-model

upload:
	aws s3 cp --acl public-read $(ROOT_DIR)/emotion.tar.gz s3://universityofprofessorex-ml-dev/emotion.tar.gz
	aws s3 cp --acl public-read $(ROOT_DIR)/human-activity-recognition.tar.gz s3://universityofprofessorex-ml-dev/human-activity-recognition.tar.gz
	aws s3 cp --acl public-read $(ROOT_DIR)/humor.tar.gz s3://universityofprofessorex-ml-dev/humor.tar.gz
	aws s3 cp --acl public-read $(ROOT_DIR)/nsfw-model.tar.gz s3://universityofprofessorex-ml-dev/nsfw-model.tar.gz
