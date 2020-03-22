note
	description: "Calendar application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT

inherit
	ARGUMENTS
	ES_SUITE

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			add_test (create {TEST_AGENT}.make)
			add_test (create {TEST_UNDO}.make)
			add_test (create {TESTS}.make)
			show_browser
			run_espec
		end

feature

end
