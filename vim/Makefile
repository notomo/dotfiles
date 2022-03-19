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

help_tags:
	nvim --headless +"lua require('notomo.startup').generate_help_tags()"
