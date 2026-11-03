export PODMAN_COMPOSE_PROVIDER ?= $(shell command -v podman-compose)
export COMPOSE_FILE ?= .container/compose.yaml

.ONESHELL:

up:
	@podman compose up --build --detach

down:
	@podman compose down

shell:
	@podman compose exec android sh

pair:
	@podman compose exec -T android sh -e <<'EOF'
	printf "addr: "
	read -r addr
	printf "code: "
	read -r code
	adb pair $${addr} $${code}
	EOF

connect:
	@podman compose exec -T android sh -e <<'EOF'
	printf "addr: "
	read -r addr
	adb connect $${addr}
	EOF

start:
	@podman compose exec -T android sh -e <<'EOF'
	cd application
	npm install
	npm exec react-native start
	EOF

run:
	@podman compose exec -T android sh -e <<'EOF'
	cd application
	npm install
	npm exec react-native run-android
	EOF

.PHONY: build
build:
	@podman compose exec -T android sh -e <<'EOF'
	out=$$(pwd)/apks
	mkdir -p $${out}
	cd application
	npm install
	cd android
	./gradlew assembleRelease --no-daemon
	mv -f app/build/outputs/apk/release/*.apk $${out}
	EOF
