note
	description: "Move operation with undo/redo"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	MOVE_BISHOP

inherit

	MOVE
		redefine
			out
		end

	DEBUG_OUTPUT
		redefine
			out
		end

create
	make

feature {NONE} -- constructor

	make(a_new_position: SQUARE)
		do
			-- To DO
		end

feature -- queries
		old_position: SQUARE
		position: SQUARE

	directions: ARRAY[TUPLE[x: INTEGER; y: INTEGER]]
		local
			x,y: INTEGER
		do
			
		end



feature -- commands

	execute
		do
				board.move_bishop (position)
		end

	undo
		do

				board.move_bishop (old_position)
		end

	redo
		do
			execute
		end

feature

	out: STRING
		do
			Result := ""
		end

	debug_output: STRING
		do
			Result := out
		end

end
