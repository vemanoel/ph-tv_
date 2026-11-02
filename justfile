export PODMAN_COMPOSE_PROVIDER := env_var_or_default(
    "PODMAN_COMPOSE_PROVIDER",
    `command -v podman-compose`
)

export COMPOSE_FILE := env_var_or_default(
    "COMPOSE_FILE",
    "compose.yaml"
)

up:
	podman compose up --build --detach

down:
	podman compose down

shell:
	podman compose exec android bash

pair address code:
	#!/usr/bin/env -S bash -e
	just shell
	adb pair {{ address }} {{ code }}

connect address:
	#!/usr/bin/env -S bash -e
	just shell
	adb connect {{ address }}

start:
	#!/usr/bin/env -S bash -e
	just shell
	cd application
	npm install
	npm exec react-native start

run:
	#!/usr/bin/env -S bash -e
	just shell
	cd application
	npm install
	npm exec react-native run-android

build:
	#!/usr/bin/env -S bash -e
	just shell
	cd application
	npm install
	cd android
	./gradlew assembleRelease --no-daemon
	out_dir=../../build
	mkdir -p ${out_dir}
	mv -f app/build/outputs/apk/release/*.apk ${out_dir}
