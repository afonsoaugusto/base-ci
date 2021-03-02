MAKEFLAGS  	+= --silent
SHELL      	 = /bin/bash

export AWS_PAGER
export env
export TF_VAR_env
export PROJECT_NAME
export TF_VAR_project_name

AWS_PAGER	 := ""

PROJECT_NAME := ${CIRCLE_PROJECT_REPONAME}
BRANCH_NAME  := ${CIRCLE_BRANCH}
COMMIT_SHA   := $(shell echo ${CIRCLE_SHA1}| head -c 7)

ifndef CIRCLE_PROJECT_REPONAME
	PROJECT_NAME   			:= $(shell basename $(CURDIR))
	BRANCH_NAME   			:= $(shell git rev-parse --abbrev-ref HEAD)
	COMMIT_SHA   			:= $(shell git rev-parse --short HEAD)
endif

env := ${BRANCH_NAME}

TF_VAR_env := ${env}
TF_VAR_project_name := ${PROJECT_NAME}

# IMAGE_REGISTRY					 := 
# IMAGE_REGISTRY_USERNAME  := 
# IMAGE_REGISTRY_TOKEN		 := 

IMAGE_NAME_COMMIT  := ${IMAGE_REGISTRY_USERNAME}/${PROJECT_NAME}:${COMMIT_SHA}-${BRANCH_NAME}
IMAGE_NAME_BRANCH  := ${IMAGE_REGISTRY_USERNAME}/${PROJECT_NAME}:${BRANCH_NAME}
IMAGE_NAME_LATEST  := ${IMAGE_REGISTRY_USERNAME}/${PROJECT_NAME}:latest

include docker.Makefile
include terraform.Makefile

build: docker-build
scan: docker-scan
publish: docker-publish
