SHELL=/bin/bash

IMAGE?=willhallonline/ansible:latest

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(realpath $(dir $(MKFILE_PATH)))

MAIN_PLAYBOOK_PATH?=$(MKFILE_DIR)/Main
SUB_PLAYBOOK_PATH?=$(MKFILE_DIR)/Sub

HOST_FILE?=$(MKFILE_DIR)/hosts_all
SCRIPT_FILE?=$(MAIN_PLAYBOOK_PATH?)/test.yaml

default:
	@echo "Usage pending"
	@echo MKFILE_PATH: ${MKFILE_PATH}
	@echo MKFILE_DIR: ${MKFILE_DIR}
	@echo MAIN_PLAYBOOK_PATH: ${MAIN_PLAYBOOK_PATH}
	@echo SUB_PLAYBOOK_PATH: ${SUB_PLAYBOOK_PATH}
	@echo HOST_FILE: ${HOST_FILE}

run:
	docker run -it --rm \
	-v ${HOST_FILE}:/host_all \
	-v ${MAIN_PLAYBOOK_PATH}:/Main \
	-v ${SUB_PLAYBOOK_PATH}:/Linux \
	${IMAGE} \
	ansible-playbook -i /host_all \
	/Main/${SCRIPT_FILE}
