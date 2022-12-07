NVIM_DIR := ${HOME}/workspace/neovim
# NVIM := ${NVIM_DIR}/build/bin/nvim
NVIM := nvim

test:
	${NVIM} --headless +"lua require('notomo.startup').test()"

update:
	${NVIM} --headless +"lua require('notomo.startup').update_plugins()"

profile:
	rm -f log
	${NVIM} --startuptime log +"lua require('notomo.startup').schedule('quitall!')"
	cat log
	rm -f log

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
	zsh -f -c 'stylua --config-path ~/dotfiles/tool/stylua.toml -- ${TARGET_PATH}/**/*.lua'

vendor:
	${NVIM} --headless +"lua require('notomo.startup').vendorlib_used_plugins()" +quitall! | xargs -I{} make vendor -C {}
	$(MAKE) status

doc:
	${NVIM} --headless +"lua require('notomo.startup').has_doc_plugins()" +quitall! | xargs -I{} make doc -C {}

status:
	${NVIM} --headless +"lua require('notomo.startup').plugins()" +quitall! | xargs -I{} $(MAKE) --no-print-directory _status TARGET_PATH={}
_status:
	@echo
	git --no-pager -C ${TARGET_PATH} status

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
	git -C ${TARGET_PATH} push
