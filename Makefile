export PODMAN_COMPOSE_PROVIDER ?= $(shell command -v podman-compose)
export COMPOSE_FILE ?= .container/compose.yaml

.ONESHELL:

.PHONY: up down shell

up:
	@ podman compose up --build --detach

down:
	@ podman compose down

shell:
	@ podman compose exec dev bash

install:
	@ podman compose run --rm dev npm install --prefix application
