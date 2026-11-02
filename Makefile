export PODMAN_COMPOSE_PROVIDER ?= $(shell command -v podman-compose)
export COMPOSE_FILE ?= .container/compose.yaml

.ONESHELL:

up:
	@podman compose up --build --detach

down:
	@podman compose down

shell:
	@podman compose exec android bash

pair:
	@podman compose exec -T android sh -e <<'EOF'
	printf "Address: "
	read address
	printf "Code: "
	read pair_code
	adb pair $$address $${pair_code}
	EOF

pair:
	@podman compose exec -T android bash -e <<'EOF'
	read -rp "Address: " address
	read -rp "Code: " pair_code
	adb pair $${address} $${pair_code}
	EOF

connect:
	@podman compose exec -T android bash -e <<'EOF'
  	read -rp "Address: " address
	adb connect $${address}
	EOF

start:
	@podman compose exec -T android bash -e <<'EOF'
	cd application
	npm install
	npm exec react-native start
	EOF

run:
	@podman compose exec -T android bash -e <<'EOF'
	cd application
	npm install
	npm exec react-native run-android
	EOF

.PHONY: build
build:
	@podman compose exec -T android bash -e <<'EOF'
	out=$$(pwd)/build
	mkdir -p $${out}
	cd application
	npm install
	cd android
	./gradlew assembleRelease --no-daemon
	mv -f app/build/outputs/apk/release/*.apk $${out}
	EOF
