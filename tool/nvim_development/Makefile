NVIM_DIR := ${HOME}/workspace/neovim
NVIM := ${NVIM_DIR}/build/bin/nvim
# NVIM := nvim

unexport LUA_PATH
unexport LUA_CPATH

build_with_asan:
	cd ${NVIM_DIR}; CC=clang-11 make CMAKE_EXTRA_FLAGS="-DCLANG_ASAN_UBSAN=ON"

build:
	cd ${NVIM_DIR}; CC=clang-11 make
.PHONY: build

all:
	# cd ${NVIM_DIR}; make distclean
	# cd ${NVIM_DIR}; make clean
	# ${MAKE} build
	${MAKE} build_with_asan
.PHONY: all

# NOTE: for print_stacktrace
# sudo ln -s /usr/bin/llvm-symbolizer-6.0 /usr/bin/llvm-symbolizer
LOG_DIR := ${HOME}/logs
# TEST_ENV := CC=clang-11 ASAN_OPTIONS=detect_leaks=1:check_initialization_order=1:log_path=${LOG_DIR}/asan UBSAN_OPTIONS=print_stacktrace=1 TEST_FILE=test/functional/eval/api_functions_spec.lua
# TEST_ENV := CC=clang-11 ASAN_OPTIONS=detect_leaks=1:check_initialization_order=1:log_path=${LOG_DIR}/asan UBSAN_OPTIONS=print_stacktrace=1 TEST_FILE=test/functional/api/window_spec.lua
TEST_ENV := CC=clang-11 ASAN_OPTIONS=detect_leaks=1:check_initialization_order=1:log_path=${LOG_DIR}/asan UBSAN_OPTIONS=print_stacktrace=1 TEST_FILE=test/functional/api/vim_spec.lua TEST_FILTER=.*nvim_echo.*
test:
	rm -rf ${LOG_DIR}
	mkdir -p ${LOG_DIR}
	cd ${NVIM_DIR}; ${TEST_ENV} make functionaltest
	# cd ${NVIM_DIR}; make functionaltest
	# cat ${LOG_DIR}/asan.*
.PHONY: test

# LSAN_OPTIONS=verbosity=1:log_threads=1 
OLDTEST_ENV := CC=clang-11 ASAN_OPTIONS=detect_leaks=1:check_initialization_order=1:log_path=${LOG_DIR}/asan UBSAN_OPTIONS=print_stacktrace=1 TEST_FILE=test_cmdline.vim
# OLDTEST_ENV := CC=clang-11 ASAN_OPTIONS=detect_leaks=1:check_initialization_order=1:log_path=${LOG_DIR}/asan UBSAN_OPTIONS=print_stacktrace=1
oldtest:
	rm -rf ${LOG_DIR}
	mkdir -p ${LOG_DIR}
	cd ${NVIM_DIR}; make oldtest ${OLDTEST_ENV}

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

gdb:
	gdb ${NVIM} core --eval-command "thread apply all bt full" --batch 2>&1 | tee backtrace.txt
.PHONY: gdb

headless:
	${NVIM} --headless -u NORC +"luafile ./minimal.lua" +"quitall!"

_run:
	# ${NVIM} -u NORC +"luafile ./minimal.lua" +"quitall!"
	# ${NVIM} -u NORC +"source ./minimal.vim" +"quitall!"
	# ${NVIM} --headless -u NORC +"luafile ./minimal.lua" +"quitall!"
	${NVIM}
	# ${NVIM} -u NORC +"source ./minimal.vim"
	# ${NVIM} -u NORC +"luafile ./minimal.lua"
.PHONY: _run

ISSUE := issue.md
issue:
	rm -f ${ISSUE}
	echo "TITLE: Segmantation fault ❗TODO❗" >> ${ISSUE}
	echo>> ${ISSUE}
	echo "- ``nvim --version``:" >> ${ISSUE}
	echo \`\`\` >> ${ISSUE}
	${NVIM} --version >> ${ISSUE}
	echo \`\`\` >> ${ISSUE}
	echo "- \`vim -u DEFAULTS\` (version: ) behaves differently? It doesn't have ❗TODO❗ api." >> ${ISSUE}
	echo "- Operating system/version: `lsb_release -i -s` `lsb_release -r -s`" >> ${ISSUE}
	echo "- Terminal name/version: wsltty" >> ${ISSUE}
	echo "- ``\$$TERM``: ${TERM}" >> ${ISSUE}
	echo>> ${ISSUE}
	echo "### Steps to reproduce using \`nvim -u NORC\`" >> ${ISSUE}
	echo>> ${ISSUE}
	echo "minimal.lua" >> ${ISSUE}
	echo \`\`\`lua >> ${ISSUE}
	cat minimal.lua >> ${ISSUE}
	echo \`\`\` >> ${ISSUE}
	echo>> ${ISSUE}
	echo "### Actual behaviour" >> ${ISSUE}
	echo>> ${ISSUE}
	echo \`\`\` >> ${ISSUE}
	echo "build/bin/nvim -u NORC +'luafile minimal.lua'"  >> ${ISSUE}
	echo "❗TODO❗" >> ${ISSUE}
	echo \`\`\` >> ${ISSUE}
	echo>> ${ISSUE}
	echo "### Expected behaviour" >> ${ISSUE}
	echo>> ${ISSUE}
	echo "No crash." >> ${ISSUE}
	echo>> ${ISSUE}
	echo "### Full backtrace" >> ${ISSUE}
	echo>> ${ISSUE}
	echo "<details>" >> ${ISSUE}
	echo "<summary>Details</summary>" >> ${ISSUE}
	echo>> ${ISSUE}
	echo \`\`\` >> ${ISSUE}
	cat backtrace.txt >> ${ISSUE}
	echo \`\`\` >> ${ISSUE}
	echo>> ${ISSUE}
	echo "</details>" >> ${ISSUE}
.PHONY: issue

event:
	${NVIM} --headless -u NORC +"luafile ./event.lua"

# doxygen:
# 	sudo apt-get install flex
# 	sudo apt-get install bison
# 	wget https://github.com/doxygen/doxygen/archive/Release_1_8_20.tar.gz -o doxygen.tar.gz
# 	tar -zxvf doxygen.tar.gz
# 	cd doxygen
# 	mkdir build
# 	cd build
# 	cmake -G "Unix Makefiles" ..
# 	make
# 	sudo make install

# clang:
# 	# https://apt.llvm.org/
# 	wget https://apt.llvm.org/llvm.sh
# 	chmod +x llvm.sh
# 	sudo ./llvm.sh 11
