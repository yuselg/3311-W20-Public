note
	description: "Summary description for {TEST_APPLICATION}."
	author: "JW and JSO"
	date: "2020-03-04"

class
	TEST_APPLICATION

inherit
	ES_TEST

create
	make

feature
	make
		do
			add_boolean_case (agent test_application)
			show_browser
			run_espec
		end

feature
	break: STRING = "<br>"

	test_application: BOOLEAN
		local
			app: APPLICATION
			current_state: STATE
			index: INTEGER  -- into array of states
		do
			comment("Create app, and populate with states and choices.")
			sub_comment (break + "Transition from Initial Panel to Enquiry Panel")
			create app.make (6, 3)

			-- single choice: create all possible states
			app.put_state (create {INITIAL}.make, 1)
			app.put_state (create {FLIGHT_ENQUIRY}.make, 2)
			app.put_state (create {SEAT_ENQUIRY}.make, 3)
			app.put_state (create {RESERVATION}.make, 4)
			app.put_state (create {CONFIRMATION}.make, 5)
			app.put_state (create {FINAL}.make, 6)

			-- choose the initial state
			app.choose_initial (1)

			-- populate the state transition graph
			-- put_transition (new_state, old_state, choice: INTEGER)
			app.put_transition (6, 1, 1)
				-- (old_state 1 Initial, choice 1) --> new_state 6 Final
			app.put_transition (2, 1, 3)
			app.put_transition (3, 2, 3)
			app.put_transition (4, 3, 3)
			app.put_transition (5, 4, 3)
			app.put_transition (1, 5, 3)
			app.put_transition (5, 1, 2)
			app.put_transition (4, 5, 2)
			app.put_transition (3, 4, 2)
			app.put_transition (2, 3, 2)
			app.put_transition (1, 2, 2)

			-- start app by going to initial state
			index := app.initial
			current_state := app.states [index]
			Result := attached {INITIAL} current_state
			check Result end

			-- Say user's choice is 3: transit from INITIAL to FLIGHT_STATUS
			index := app.transition[index, 3]
			current_state := app.states [index]
			Result := attached {FLIGHT_ENQUIRY} current_state
			check Result end
		end

end
