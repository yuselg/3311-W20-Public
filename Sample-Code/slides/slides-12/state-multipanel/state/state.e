note
	description: "[
		Abstract design class to represent a state.
		Alter behaviour when the internal state changes.
	]"
	author: "JW and JSO"
	date: "2020-03-04"

deferred class
	STATE

feature -- Abstract Features

	read
			-- Read user's inputs
			-- Set 'answer' and 'choice'
		deferred
		end

	answer: ANSWER
			-- Answer for current state

	choice: INTEGER
			-- Choice for next step

	display
			-- Display current state
		deferred
		end

	correct: BOOLEAN
		deferred
		end

	process
		require
			correct
		deferred
		end

	message
		require
			not correct
		deferred
		end

feature -- Concrete Features

	make
		do
			create answer.make
		end

	execute
			-- template for state behavior
		local
			good: BOOLEAN
		do
			from
			until
				good
			loop
				display
					-- set answer and choice
				read
				good := correct
				if not good then
					message
				end
			end
			process
		end

end
