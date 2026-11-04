export

PODMAN_COMPOSE_PROVIDER ?= $(shell command -v podman-compose)
COMPOSE_FILE ?= .container/compose.yaml
PODMAN_COMPOSE_WARNING_LOGS=false

.ONESHELL:

up:
	@podman compose up --build --detach

down:
	@podman compose down

sh:
	@podman compose exec development sh

pair:
	@podman compose exec -T development sh -e <<'EOF'
	printf "addr: "
	read -r addr
	printf "code: "
	read -r code
	adb pair $${addr} $${code}
	EOF

connect:
	@podman compose exec -T development sh -e <<'EOF'
	printf "addr: "
	read -r addr
	adb connect $${addr}
	EOF

start:
	@podman compose exec -T development sh -e <<'EOF'
	cd application
	npm install
	npm exec react-native start
	EOF

run:
	@podman compose exec -T development sh -e <<'EOF'
	cd application
	npm install
	npm exec react-native run-android
	EOF

build:
	@podman compose exec -T development sh -e <<'EOF'
	out=$$(pwd)/apks
	mkdir -p $${out}
	cd application
	npm install
	cd android
	./gradlew assembleRelease --no-daemon --warning-mode all
	mv -f app/build/outputs/apk/release/*.apk $${out}
	EOF
