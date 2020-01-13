note
	description: "[
		ROOT class to test SEARCHING[G].
	]"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

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
			add_test (create {TEST_SEARCHING}.make) --suite of tests
			show_browser
			run_espec
		end

end
