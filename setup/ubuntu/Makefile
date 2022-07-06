IMAGE_NAME:=notomo_dev

DEP_DIR:=./tmp
$(DEP_DIR):
	mkdir -p ${DEP_DIR}

$(DEP_DIR)/ansible: $(DEP_DIR)
	cp -rf ./../../ansible $@

$(DEP_DIR)/.ssh: $(DEP_DIR)
	mkdir -p ~/.ssh
	cp -rf ~/.ssh $@

$(DEP_DIR)/thetto.nvim: $(DEP_DIR)
	mkdir -p ~/.local/share/nvim/thetto.nvim
	cp -rf ~/.local/share/nvim/thetto.nvim $@

build: $(DEP_DIR)/ansible $(DEP_DIR)/.ssh $(DEP_DIR)/thetto.nvim
	DOCKER_BUILDKIT=1 docker build --progress=plain -f ./Dockerfile -t ${IMAGE_NAME} ${DEP_DIR}

start:
	docker run --rm -it ${IMAGE_NAME} bash

VHDX_DIR:=/mnt/c/wsl/${IMAGE_NAME}
TAR_FILE_NAME:=${IMAGE_NAME}.tar.gz
TAR_PATH:=${VHDX_DIR}/${TAR_FILE_NAME}
vhdx_dir:
	mkdir -p ${VHDX_DIR}

TMP_CONTAINER_NAME:=tmp_${IMAGE_NAME}
tar: vhdx_dir
	docker create -t --name ${TMP_CONTAINER_NAME} ${IMAGE_NAME} echo
	docker export `docker inspect --format="{{.Id}}" ${TMP_CONTAINER_NAME}` -o ${TAR_PATH}
	docker rm -f ${TMP_CONTAINER_NAME}

import: vhdx_dir
	cd ${VHDX_DIR}; wsl.exe --import ${IMAGE_NAME} . ./${TAR_FILE_NAME}

unregister:
	wsl.exe --unregister ${IMAGE_NAME}
list:
	wsl.exe --list
terminate:
	wsl.exe --terminate ${IMAGE_NAME}
