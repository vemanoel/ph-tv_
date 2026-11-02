export PODMAN_COMPOSE_PROVIDER ?= $(shell command -v podman-compose)
export COMPOSE_FILE ?= .container/compose.dev.yaml

.ONESHELL:

up:
	podman compose up --build --detach

down:
	podman compose down

shell:
	podman compose exec android bash

pair:
	podman compose exec android bash -e <<'EOF'
	read -rp "Address: " address
	read -rp "Code: " pair_code
	adb pair $${address} $${pair_code}
	EOF

connect:
	podman compose exec android bash -e <<'EOF'
  	read -rp "Address: " address
	adb connect $${address}
	EOF

start:
	podman compose exec android bash -e <<'EOF'
	cd application
	npm install
	npm exec react-native start
	EOF

run:
	podman compose exec android bash -e <<'EOF'
	cd application
	npm install
	npm exec react-native run-android
	EOF

build:
	podman compose exec android bash -e <<'EOF'
	cd /workspace/application
	npm install
	cd android
	./gradlew assembleRelease --no-daemon
	mkdir -p ../../build
	mv -f app/build/outputs/apk/release/*.apk ../../build/
	EOF
