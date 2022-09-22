NVIM_DIR := ${HOME}/workspace/neovim
NVIM := ${NVIM_DIR}/build/bin/nvim
NVIM_WITH_RUNTIME := VIMRUNTIME=${NVIM_DIR}/runtime ${NVIM}
# NVIM := nvim
ASAN_NVIM := ./bin/asan_nvim
# NVIM := ./bin/asan_nvim

CC := clang-11
unexport LUA_PATH
unexport LUA_CPATH

all:
	cd ${NVIM_DIR}; make distclean
	# cd ${NVIM_DIR}; make clean
	${MAKE} build
	# ${MAKE} build_with_asan
.PHONY: all

build_with_asan: reset_build_type
	cd ${NVIM_DIR}; make CMAKE_EXTRA_FLAGS="-DCLANG_ASAN_UBSAN=ON"
	cp ${NVIM_WITH_RUNTIME} ${ASAN_NVIM}
.PHONY: build_with_asan

build_release_with_deb_info: reset_build_type
	nvim --version
	# cd ${NVIM_DIR}; make distclean
	cd ${NVIM_DIR}; LUAC_PRG=luac5.1 make CMAKE_BUILD_TYPE=RelWithDebInfo
	rm -rf ${HOME}/.local/nvim/share/nvim/runtime
	cd ${NVIM_DIR}; make install CMAKE_INSTALL_PREFIX=${HOME}/.local/nvim
	nvim --version
	$(MAKE) -C ./../../vim test
	$(MAKE) -C ./../../vim profile
.PHONY: build_release_with_deb_info

reset_build_type:
	cd ${NVIM_DIR}; rm -rf ./build/.ran-cmake
.PHONY: reset_build_type

build:
	cd ${NVIM_DIR}; make CMAKE_BUILD_TYPE=Debug
.PHONY: build

# NOTE: for print_stacktrace
# sudo ln -s /usr/bin/llvm-symbolizer-6.0 /usr/bin/llvm-symbolizer
LOG_DIR := ${HOME}/logs
NVIM_LOG_FILE := ${NVIM_DIR}/build/.nvimlog
ASAN_OPTIONS := detect_leaks=1:check_initialization_order=1:log_path=${LOG_DIR}/asan
UBSAN_OPTIONS := print_stacktrace=1
test:
	rm -rf ${LOG_DIR} ${NVIM_DIR}/build/.nvimlog
	mkdir -p ${LOG_DIR}
	cd ${NVIM_DIR}; make functionaltest
	# cat ${LOG_DIR}/asan.*
.PHONY: test

oldtest:
	rm -rf ${LOG_DIR}
	mkdir -p ${LOG_DIR}
	cd ${NVIM_DIR}; make oldtest
.PHONY: oldtest

lint:
	cd ${NVIM_DIR}; make clint-full
.PHONY: lint

run:
	ulimit -c unlimited
	touch minimal.lua
	rm -f core
	rm -f backtrace.txt
	${MAKE} _run || echo
	${MAKE} gdb
.PHONY: run

version:
	${NVIM_WITH_RUNTIME} --version
.PHONY: version

gdb:
	gdb ${NVIM} core --eval-command "thread apply all bt full" --batch 2>&1 | tee backtrace.txt
.PHONY: gdb

headless:
	${NVIM_WITH_RUNTIME} --headless --clean +"luafile ./minimal.lua" +"quitall!"
.PHONY: headless

start: _run
.PHONY: start

_run:
	# ${NVIM_WITH_RUNTIME} --clean +"luafile ./minimal.lua"
	# ${NVIM_WITH_RUNTIME} --clean +"luafile ./minimal.lua" +"quitall!"
	${NVIM_WITH_RUNTIME} --clean --headless +"luafile ./minimal.lua" +"quitall!"
	# ${NVIM_WITH_RUNTIME} --clean --headless +"source ./minimal.vim" +"quitall!"
	# ${NVIM_WITH_RUNTIME} --clean +"source ./minimal.vim" +"quitall!"
	# ${NVIM_WITH_RUNTIME} --clean +"source ./minimal.vim"
	# ${NVIM_WITH_RUNTIME}
.PHONY: _run

ISSUE := issue.md
EXTENSION:=lua
# EXTENSION:=vim
ifeq (${EXTENSION},lua)
	REPRODUCE_CMD:=luafile minimal.${EXTENSION}
else
	REPRODUCE_CMD:=source minimal.${EXTENSION}
endif
issue:
	rm -f ${ISSUE}
	echo "TITLE: Segmentation fault ❗TODO❗" >> ${ISSUE}
	echo>> ${ISSUE}
	echo "- ``nvim --version``:" >> ${ISSUE}
	echo \`\`\` >> ${ISSUE}
	${NVIM} --version >> ${ISSUE}
	echo \`\`\` >> ${ISSUE}
	echo "- \`Vim (not Nvim) behaves the same? no, vim 8.x.yyyy" >> ${ISSUE}
	echo \`\`\` >> ${ISSUE}
	${VIM} --version >> ${ISSUE}
	echo \`\`\` >> ${ISSUE}
	echo "- Operating system/version: `lsb_release -i -s` `lsb_release -r -s`" >> ${ISSUE}
	echo "- Terminal name/version: wsltty" >> ${ISSUE}
	echo "- ``\$$TERM``: ${TERM}" >> ${ISSUE}
	echo "- Installation: build from repo" >> ${ISSUE}
	echo>> ${ISSUE}
	echo "### Steps to reproduce using \`nvim --clean NORC\`" >> ${ISSUE}
	echo>> ${ISSUE}
	echo minimal.${EXTENSION} >> ${ISSUE}
	echo \`\`\`${EXTENSION} >> ${ISSUE}
	cat minimal.${EXTENSION} >> ${ISSUE}
	echo \`\`\` >> ${ISSUE}
	echo>> ${ISSUE}
	echo \`\`\` >> ${ISSUE}
	echo "build/bin/nvim --clean +'${REPRODUCE_CMD}'"  >> ${ISSUE}
	echo "zsh: segmentation fault (core dumped)" >> ${ISSUE}
	echo \`\`\` >> ${ISSUE}
	echo>> ${ISSUE}
	echo "### Expected behaviour" >> ${ISSUE}
	echo>> ${ISSUE}
	echo "No crash." >> ${ISSUE}
	echo>> ${ISSUE}
	echo "### Actual behaviour" >> ${ISSUE}
	echo>> ${ISSUE}
	echo "Crash." >> ${ISSUE}
	echo>> ${ISSUE}
	echo \`\`\` >> ${ISSUE}
	echo "build/bin/nvim --clean --headless +'${REPRODUCE_CMD}'" >> ${ISSUE}
	echo \`\`\` >> ${ISSUE}
	echo>> ${ISSUE}
	echo "<details>" >> ${ISSUE}
	echo "<summary>Full backtrace</summary>" >> ${ISSUE}
	echo>> ${ISSUE}
	echo \`\`\` >> ${ISSUE}
	cat backtrace.txt >> ${ISSUE}
	echo \`\`\` >> ${ISSUE}
	echo>> ${ISSUE}
	echo "</details>" >> ${ISSUE}
.PHONY: issue

event:
	${NVIM_WITH_RUNTIME} --headless --clean +"luafile ./event.lua"
.PHONY: event

# clang:
# 	# https://apt.llvm.org/
# 	wget https://apt.llvm.org/llvm.sh
# 	chmod +x llvm.sh
# 	sudo ./llvm.sh 11

VIM_DIR := ${HOME}/app/vim/src
VIM := ${VIM_DIR}/vim
vim:
	cd ${VIM_DIR}; ./configure --with-features=huge
	cd ${VIM_DIR}; make
.PHONY: vim

vim_run:
	${VIM} -es -u NONE +"source ./minimal.vim" +"quitall!"
.PHONY: vim_run
