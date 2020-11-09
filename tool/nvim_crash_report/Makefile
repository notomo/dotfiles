NVIM_DIR := ${HOME}/workspace/neovim
NVIM := ${NVIM_DIR}/build/bin/nvim

unexport LUA_PATH
unexport LUA_CPATH
build:
	cd ${NVIM_DIR}; CC=clang make CMAKE_EXTRA_FLAGS="-DCLANG_ASAN_UBSAN=ON"
	# cd ${NVIM_DIR}; CC=clang make
.PHONY: build

all:
	cd ${NVIM_DIR}; make distclean
	# cd ${NVIM_DIR}; make clean
	${MAKE} build
.PHONY: all

# NOTE: for print_stacktrace
# sudo ln -s /usr/bin/llvm-symbolizer-6.0 /usr/bin/llvm-symbolizer
TEST_ENV := CC=clang ASAN_OPTIONS=detect_leaks=1:check_initialization_order=1 UBSAN_OPTIONS=print_stacktrace=1 TEST_FILE=test/functional/lua/buffer_updates_spec.lua
test:
	cd ${NVIM_DIR}; ${TEST_ENV} make CMAKE_EXTRA_FLAGS="-DCLANG_ASAN_UBSAN=ON" functionaltest
.PHONY: test

lint:
	cd ${NVIM_DIR}; make clint-full
.PHONY: lint

run:
	ulimit -c unlimited
	touch minimal.lua
	rm -f core
	rm -f backtrace.txt
	${MAKE} _run || echo
	gdb ${NVIM} core --eval-command "thread apply all bt full" --batch 2>&1 | tee backtrace.txt
.PHONY: run

_run:
	${NVIM} -u NORC +"luafile ./minimal.lua"
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
