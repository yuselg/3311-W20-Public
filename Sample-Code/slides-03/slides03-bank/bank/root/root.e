note
	description: "[
		ROOT class to test bank system
	]"
	author: "JSO"
	date: "2020-01-05"

class
	ROOT

inherit

	ES_SUITE -- testing via ESpec

create
	make

feature {NONE} -- Initialization

	make
			-- Run app
		do
			print ("Start tests of bank")
			add_test (create {TEST_BANK}.make) --suite of tests
			show_browser
--			show_errors
			run_espec
		end

end
