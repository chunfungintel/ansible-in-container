SHELL=/bin/bash

IMAGE?=willhallonline/ansible:latest

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(realpath $(dir $(MKFILE_PATH)))

MAIN_PLAYBOOK_PATH?=$(MKFILE_DIR)/Main
SUB_PLAYBOOK_PATH?=$(MKFILE_DIR)/Sub

HOST_FILE?=$(MKFILE_DIR)/hosts_all
SCRIPT_FILE?=$(MAIN_PLAYBOOK_PATH?)/test.yaml

define host_file
[ubuntu]
ubuntu00 ansible_host=10.226.76.18

[ubuntu:vars]
ansible_connection=ssh
ansible_user="ubuntu"
#ansible_ssh_private_key_file={{ playbook_dir }}/{{ playbook_location }}/Windows/files/id_rsa
ansible_ssh_pass="123456"
ansible_port=22
ansible_sudo_pass="123456"
ansible_ssh_common_args="-o StrictHostKeyChecking=no -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null"
endef
HOST_NAME?=10.226.76.18
HOST_USER?=ubuntu
HOST_PW?=123456

default:
	@echo "Usage pending"
	@echo MKFILE_PATH: ${MKFILE_PATH}
	@echo MKFILE_DIR: ${MKFILE_DIR}
	@echo MAIN_PLAYBOOK_PATH: ${MAIN_PLAYBOOK_PATH}
	@echo SUB_PLAYBOOK_PATH: ${SUB_PLAYBOOK_PATH}
	@echo HOST_FILE: ${HOST_FILE}
	@echo ${host_file}

run_hostfile:
	docker run -it --rm \
	-v ${HOST_FILE}:/host_all \
	-v ${MAIN_PLAYBOOK_PATH}:/Main \
	-v ${SUB_PLAYBOOK_PATH}:/Linux \
	${IMAGE} \
	ansible-playbook -i /host_all \
	/Main/${SCRIPT_FILE}

run:
	docker run -it --rm \
	-v ${MAIN_PLAYBOOK_PATH}:/Main \
	-v ${SUB_PLAYBOOK_PATH}:/Linux \
	${IMAGE} \
	ansible-playbook \
	-i ${HOST_NAME}, \
	-e 'ansible_connection=ssh ansible_user=${HOST_USER} ansible_ssh_pass="${HOST_PW}" ansible_port=22 ansible_sudo_pass="${HOST_PW}"' \
	--ssh-common-args '-o StrictHostKeyChecking=no -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null' \
	/Main/${SCRIPT_FILE}

