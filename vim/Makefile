NVIM_DIR := ${HOME}/workspace/neovim
# NVIM := ${NVIM_DIR}/build/bin/nvim
NVIM := nvim

test:
	${NVIM} --headless +"lua require('notomo.startup').test()"

profile:
	rm -f log
	${NVIM} --startuptime log +"lua require('notomo.startup').schedule('quitall!')"
	cat log
	rm -f log

update:
	${NVIM} --headless +"lua require('notomo.startup').update_plugins()"

help_tags:
	${NVIM} --headless +"lua require('notomo.startup').generate_help_tags()"

version:
	${NVIM} --version

# plugin development

test_all:
	${NVIM} --headless +"lua require('notomo.startup').plugins()" +quitall! | xargs -I{} make test -C {}

format:
	${NVIM} --headless +"lua require('notomo.startup').plugins()" +quitall! | xargs -I{} $(MAKE) --no-print-directory _format TARGET_PATH={}
	$(MAKE) --no-print-directory _format TARGET_PATH=${HOME}/dotfiles
_format:
	@echo
	zsh -f -c 'stylua --config-path ${DOTFILES}/tool/stylua.toml -- ${TARGET_PATH}/**/*.lua'

vendor:
	${NVIM} --headless +"lua require('notomo.startup').vendorlib_used_plugins()" +quitall! | xargs -I{} make vendor -C {}
	$(MAKE) status

doc:
	${NVIM} --headless +"lua require('notomo.startup').has_doc_plugins()" +quitall! | xargs -I{} make doc -C {}

pull_shared:
	${NVIM} --headless +"lua require('notomo.startup').plugin_shared_dirs()" +quitall! | xargs -I{} git --no-pager -C {} pull origin

status:
	${NVIM} --headless +"lua require('notomo.startup').plugins()" +quitall! | xargs -I{} $(MAKE) --no-print-directory _status TARGET_PATH={}
_status:
	@echo
	git --no-pager -C ${TARGET_PATH} status

diff:
	${NVIM} --headless +"lua require('notomo.startup').plugins()" +quitall! | xargs -I{} $(MAKE) --no-print-directory _diff TARGET_PATH={}
_diff:
	@echo
	git --no-pager -C ${TARGET_PATH} diff

commit:
	${NVIM} --headless +"lua require('notomo.startup').plugins()" +quitall! | xargs -I{} $(MAKE) --no-print-directory _commit TARGET_PATH={}
_commit:
	@echo
	test '${MESSAGE}'
	test '${TARGET_PATH}'
	git -C ${TARGET_PATH} add .
	git -C ${TARGET_PATH} commit -m '${MESSAGE}'

PUSH:
	${NVIM} --headless +"lua require('notomo.startup').plugins()" +quitall! | xargs -I{} $(MAKE) --no-print-directory _PUSH TARGET_PATH={}
_PUSH:
	if [ -n "$$(git -C ${TARGET_PATH} log --pretty=format:1 @{u}..)" ]; \
	then \
	  git -C ${TARGET_PATH} push; \
	fi
