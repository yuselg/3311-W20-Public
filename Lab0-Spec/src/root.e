note
	description: "[
		ROOT class for project
		See tests in TEST_EXAMPLE
		Place your own classes in cluster model (recursive).
		There is no precompile.
	]"
	author: "JSO"

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
			print ("Starting snooker tests ..%N")
			add_test (create {TEST_SNOOKER}.make) --suite of tests
			show_browser
			run_espec
		end

end
