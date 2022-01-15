test:
	nvim --headless +"lua require('notomo.startup').test()"

profile:
	rm -f log
	nvim --startuptime log +"lua require('notomo.startup').schedule('quitall!')"
	cat log
	rm -f log
