export PODMAN_COMPOSE_PROVIDER ?= $(shell command -v podman-compose)
export COMPOSE_FILE ?= .container/compose.yaml

init:
	@ podman compose build

run:
	@ podman compose run -T --rm dev $(ARGS)

build:
	@ mkdir -p build
	@ chmod 777 build
	@ podman compose run -T --rm dev -e GOOS=darwin -e GOARCH=amd64 go build -ldflags "-s -w" -o build/darwin-amd64 cmd/main.go
	@ podman compose run -T --rm dev -e GOOS=darwin -e GOARCH=arm64 go build -ldflags "-s -w" -o build/darwin-arm64 cmd/main.go
	@ podman compose run -T --rm dev -e GOOS=linux -e GOARCH=amd64 go build -ldflags "-s -w" -o build/linux-amd64 cmd/main.go
	@ podman compose run -T --rm dev -e GOOS=linux -e GOARCH=386 go build -ldflags "-s -w" -o build/linux-386 cmd/main.go
	@ podman compose run -T --rm dev -e GOOS=windows -e GOARCH=amd64 go build -ldflags "-s -w" -o build/windows-amd64.exe cmd/main.go
	@ podman compose run -T --rm dev -e GOOS=windows -e GOARCH=386 go build -ldflags "-s -w" -o build/windows-386.exe cmd/main.go
