test:
	nvim --headless +"lua require('notomo.startup').test()"

profile:
	rm -f log
	nvim --startuptime log +"lua require('notomo.startup').schedule('quitall!')"
	cat log
	rm -f log

test_plugins:
	nvim --headless +"lua require('notomo.startup').plugins()" +quitall! | xargs -I{} make test -C {}

vendor_plugins:
	nvim --headless +"lua require('notomo.startup').vendorlib_used_plugins()" +quitall! | xargs -I{} make vendor -C {}
	$(MAKE) vendor_plugins_status

vendor_plugins_status:
	nvim --headless +"lua require('notomo.startup').vendorlib_used_plugins()" +quitall! | xargs -I{} git --no-pager -C {} status --short

test_vendor_plugins:
	nvim --headless +"lua require('notomo.startup').vendorlib_used_plugins()" +quitall! | xargs -I{} make test -C {}

list_vendor_plugins:
	nvim --headless +"lua require('notomo.startup').vendorlib_used_plugins()" +quitall!

help_tags:
	nvim --headless +"lua require('notomo.startup').generate_help_tags()"
