export PODMAN_COMPOSE_PROVIDER ?= $(shell command -v podman-compose)
export COMPOSE_FILE ?= .container/compose.dev.yaml

up:
	@podman compose up --build --detach

down:
	@podman compose down

shell:
	@podman compose exec android bash

install:
	@npm install --prefix application
