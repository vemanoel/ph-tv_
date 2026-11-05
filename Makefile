.ONESHELL:

export

PODMAN_COMPOSE_PROVIDER ?= $(shell command -v podman-compose)
COMPOSE_FILE ?= compose.yaml
PODMAN_COMPOSE_WARNING_LOGS = false

up:
	@podman compose up --build --detach

down:
	@podman compose down

sh:
	@podman compose exec development sh

pair:
	@podman compose exec -T development sh -e <<'EOF'
	printf "address: "
	read -r address

	printf "pair code: "
	read -r pair_code

	adb pair $$address $$code
	EOF

connect:
	@podman compose exec -T development sh -e <<'EOF'
	printf "address: "
	read -r address

	adb connect $$address
	EOF

start:
	@podman compose exec -T development sh -e <<'EOF'
	npm install
	npm exec react-native start
	EOF

run:
	@podman compose exec -T development sh -e <<'EOF'
	npm install
	npm exec react-native run-android
	EOF

build:
	@podman compose exec -T development sh -e <<'EOF'
	export ORG_GRADLE_PROJECT_VERSION_NAME=$(VERSION_NAME)
	export ORG_GRADLE_PROJECT_VERSION_CODE=$(VERSION_CODE)

	npm install

	cd android
	./gradlew clean
	./gradlew assembleRelease --no-daemon --warning-mode all

	OUTDIR=$${OUTDIR:-$$(pwd)/apks}
	mkdir -p $$OUTDIR
	mv -f app/build/outputs/apk/release/*.apk $$OUTDIR
	EOF
