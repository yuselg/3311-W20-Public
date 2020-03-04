note
	description: "Summary description for {INITIAL}."
	author: "JW and JSO"
	date: "2020-03-04"

class
	SEAT_ENQUIRY

inherit

	STATE
		redefine
			out
		end

create
	make

feature

	read
			-- Read user's inputs
			-- Set 'answer' and 'choice'
		do
		end

	display
			-- Display current state
		do
		end

	correct: BOOLEAN
		do
		end

	process
		do
		end

	message
		do
		end

feature

	out: STRING
		do
			Result := "State SEAT_ENQUIRY"
		end

end
