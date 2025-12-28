IMAGE_NAME:=notomo_dev
TARGET:=${IMAGE_NAME}2

DEP_DIR:=./tmp
$(DEP_DIR):
	mkdir -p ${DEP_DIR}

$(DEP_DIR)/thetto.nvim: $(DEP_DIR)
	mkdir -p ~/.local/share/nvim/thetto.nvim
	cp -rf ~/.local/share/nvim/thetto.nvim $@

$(DEP_DIR)/mise: $(DEP_DIR)
	cp -rf ./../../mise $@
$(DEP_DIR)/shell: $(DEP_DIR)
	cp -rf ./../shell $@
$(DEP_DIR)/git: $(DEP_DIR)
	cp -rf ./../git $@

$(DEP_DIR)/gh: $(DEP_DIR)
	cp -rf ~/.config/gh $@

$(DEP_DIR)/.bash_profile: $(DEP_DIR)
	# for mise github rate limit
	@echo "export GITHUB_TOKEN=`gh auth token`" > $@
$(DEP_DIR)/.bashrc: $(DEP_DIR)
	cp -rf ~/.local/.bashrc $@

$(DEP_DIR)/wslu.sh: $(DEP_DIR)
	cp -rf wslu.sh $@
$(DEP_DIR)/workspace.sh: $(DEP_DIR)
	cp -rf ./../workspace.sh $@

BUILD_EXTRA_ARG:=
build: $(DEP_DIR)/thetto.nvim $(DEP_DIR)/mise $(DEP_DIR)/shell $(DEP_DIR)/git $(DEP_DIR)/gh $(DEP_DIR)/.bash_profile $(DEP_DIR)/.bashrc $(DEP_DIR)/wslu.sh $(DEP_DIR)/workspace.sh
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
	cd ${VHDX_DIR}; /mnt/c/Windows/System32/wsl.exe --import ${TARGET} . ./${TAR_FILE_NAME}

unregister:
	/mnt/c/Windows/System32/wsl.exe --unregister ${TARGET}
list:
	/mnt/c/Windows/System32/wsl.exe --list
terminate:
	/mnt/c/Windows/System32/wsl.exe --terminate ${TARGET}
