IMAGE_NAME:=notomo_dev
TARGET:=${IMAGE_NAME}2

DEP_DIR:=./tmp
$(DEP_DIR):
	mkdir -p ${DEP_DIR}

$(DEP_DIR)/ansible: $(DEP_DIR)
	cp -rf ./../../ansible $@

$(DEP_DIR)/thetto.nvim: $(DEP_DIR)
	mkdir -p ~/.local/share/nvim/thetto.nvim
	cp -rf ~/.local/share/nvim/thetto.nvim $@

BUILD_EXTRA_ARG:=
build: $(DEP_DIR)/ansible $(DEP_DIR)/thetto.nvim
	DOCKER_BUILDKIT=1 docker build --progress=plain -f ./Dockerfile -t ${IMAGE_NAME} ${DEP_DIR} ${BUILD_EXTRA_ARG}

check: BUILD_EXTRA_ARG=--check
check: build

start:
	docker run --rm -it ${IMAGE_NAME} bash

VHDX_DIR:=/mnt/c/wsl/${TARGET}
TAR_FILE_NAME:=${TARGET}.tar.gz
TAR_PATH:=${VHDX_DIR}/${TAR_FILE_NAME}
vhdx_dir:
	mkdir -p ${VHDX_DIR}

TMP_CONTAINER_NAME:=tmp_${IMAGE_NAME}
tar: vhdx_dir
	docker create -t --name ${TMP_CONTAINER_NAME} ${IMAGE_NAME} echo
	docker export `docker inspect --format="{{.Id}}" ${TMP_CONTAINER_NAME}` -o ${TAR_PATH}
	docker rm -f ${TMP_CONTAINER_NAME}

import: vhdx_dir
	cd ${VHDX_DIR}; wsl.exe --import ${TARGET} . ./${TAR_FILE_NAME}

unregister:
	wsl.exe --unregister ${TARGET}
list:
	wsl.exe --list
terminate:
	wsl.exe --terminate ${TARGET}
