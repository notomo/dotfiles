NVIM_DIR := ${HOME}/workspace/neovim
# NVIM := ${NVIM_DIR}/build/bin/nvim
NVIM := nvim

test:
	$(MAKE) requireall
	${NVIM} --headless +'lua require("notomo.lib.startup").test()'

requireall:
	${NVIM} --headless +'lua require("notomo.lib.startup").requireall()'

profile:
	rm -f log
	${NVIM} --startuptime log +'lua require("notomo.lib.startup").quit_after_start()'
	cat log
	rm -f log

update:
	${NVIM} --headless +'lua require("notomo.lib.startup").update_plugins()'

help_tags:
	${NVIM} --headless +'lua require("notomo.lib.startup").generate_help_tags()'

version:
	${NVIM} --version

# plugin development

test_all:
	${NVIM} --headless +'lua require("notomo.lib.startup").plugins()' +quitall! | xargs -I{} make test -C {}

check_all:
	${NVIM} --headless +'lua require("notomo.lib.startup").plugins()' +quitall! | xargs -I{} make check -C {}

format:
	${NVIM} --headless +'lua require("notomo.lib.startup").plugins()' +quitall! | xargs -I{} $(MAKE) --no-print-directory _format TARGET_PATH={}
	$(MAKE) --no-print-directory _format TARGET_PATH=${HOME}/dotfiles
_format:
	@echo
	zsh -f -c 'stylua --config-path ${HOME}/.vim/packages/pack/mypack/opt/cmdbuf.nvim/stylua.toml -- ${TARGET_PATH}/**/*.lua'

vendor:
	${NVIM} --headless +'lua require("notomo.lib.startup").vendorlib_used_plugins()' +quitall! | xargs -I{} make vendor -C {}
	$(MAKE) status

doc:
	${NVIM} --headless +'lua require("notomo.lib.startup").has_doc_plugins()' +quitall! | xargs -I{} make doc -C {}

sync_config:
	${NVIM} --headless +'lua require("notomo.lib.startup").plugins()' +quitall! | xargs -I{} make sync_config -C {}

pull_shared:
	# ${NVIM} --headless +'lua require("notomo.lib.startup").plugin_shared_dirs()' +quitall! | xargs -I{} git --no-pager -C {} reset --hard
	${NVIM} --headless +'lua require("notomo.lib.startup").plugin_shared_dirs()' +quitall! | xargs -I{} git --no-pager -C {} pull origin

reset:
	${NVIM} --headless +'lua require("notomo.lib.startup").plugins()' +quitall! | xargs -I{} git --no-pager -C {} add .
	${NVIM} --headless +'lua require("notomo.lib.startup").plugins()' +quitall! | xargs -I{} git --no-pager -C {} reset --hard

status:
	${NVIM} --headless +'lua require("notomo.lib.startup").plugins()' +quitall! | xargs -I{} $(MAKE) --no-print-directory _status TARGET_PATH={}
_status:
	@echo
	git --no-pager -C ${TARGET_PATH} status

diff:
	${NVIM} --headless +'lua require("notomo.lib.startup").plugins()' +quitall! | xargs -I{} $(MAKE) --no-print-directory _diff TARGET_PATH={}
_diff:
	@echo
	git --no-pager -C ${TARGET_PATH} diff

commit:
	${NVIM} --headless +'lua require("notomo.lib.startup").plugins()' +quitall! | xargs -I{} $(MAKE) --no-print-directory _commit TARGET_PATH={}
_commit:
	@echo
	test '${MESSAGE}'
	test '${TARGET_PATH}'
	git -C ${TARGET_PATH} add .
	git -C ${TARGET_PATH} commit -m '${MESSAGE}'

PUSH:
	${NVIM} --headless +'lua require("notomo.lib.startup").plugins()' +quitall! | xargs -I{} $(MAKE) --no-print-directory _PUSH TARGET_PATH={}
_PUSH:
	if [ -n "$$(git -C ${TARGET_PATH} log --pretty=format:1 @{u}..)" ]; \
	then \
	  git -C ${TARGET_PATH} push; \
	fi
