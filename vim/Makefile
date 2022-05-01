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

test_plugins:
	nvim --headless +"lua require('notomo.startup').plugins()" +quitall! | xargs -I{} make test -C {}

vendor_plugins:
	nvim --headless +"lua require('notomo.startup').vendorlib_used_plugins()" +quitall! | xargs -I{} make vendor -C {}
	$(MAKE) vendor_plugins_status

vendor_plugins_status:
	nvim --headless +"lua require('notomo.startup').vendorlib_used_plugins()" +quitall! | xargs -I{} $(MAKE) --no-print-directory _status TARGET_PATH={}

_status:
	@echo
	git --no-pager -C ${TARGET_PATH} status

test_vendor_plugins:
	nvim --headless +"lua require('notomo.startup').vendorlib_used_plugins()" +quitall! | xargs -I{} make test -C {}

list_vendor_plugins:
	nvim --headless +"lua require('notomo.startup').vendorlib_used_plugins()" +quitall!

help_tags:
	nvim --headless +"lua require('notomo.startup').generate_help_tags()"

version:
	${NVIM} --version
