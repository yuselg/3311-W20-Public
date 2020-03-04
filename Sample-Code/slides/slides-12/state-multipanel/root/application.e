note
	description: "[
		Multi-panel app.
		Interactive system to respond to user choices
		]"
	date: "2020-03-04"

class
	APPLICATION

create
	make

feature {TEST_APPLICATION} -- model

	transition: ARRAY2 [INTEGER]
			-- State transitions: transition[state, choice]

	states: ARRAY [STATE]
			-- State for each index, constrained by size of `transition'

feature

	initial: INTEGER

	num_of_states: INTEGER

	num_of_choices: INTEGER

	make (n, m: INTEGER)
		do
			num_of_states := n
			num_of_choices := m
			create transition.make_filled (0, num_of_states, num_of_choices)
			create states.make_empty
		end

feature

	is_final (index: INTEGER): BOOLEAN
		do
			Result := index = -1
		end

feature -- Commands

	put_state (s: STATE; index: INTEGER)
		require
			1 <= index and index <= num_of_states
		do
			states.force (s, index)
		end

	choose_initial (index: INTEGER)
		require
			1 <= index and index <= num_of_states
		do
			initial := index
		end

	put_transition (new_state, old_state, choice: INTEGER)
			--
		require
			1 <= old_state and old_state <= num_of_states
			1 <= new_state and new_state <= num_of_states
			1 <= choice and choice <= num_of_choices
		do
			transition.put (new_state, old_state, choice)
		end

	execute_session
			-- event loop based on user choices
		local
			current_state: STATE
			index: INTEGER
		do
			from
				index := initial
			until
				is_final (index)
			loop
				current_state := states [index] -- polymorphism
				current_state.execute -- dynamic binding
				index := transition.item (index, current_state.choice)
			end
		end

invariant
	transition.height = num_of_states
	transition.width = num_of_choices
end
