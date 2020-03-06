note
	description: "Root for the business logic of game"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- create
	make
			-- Initialization for `Current'.
		do
			message := "ok, K = King and B = Bishop"
			make_board (5) -- minimum size
		end

feature -- board

    make_board(a_size:INTEGER)
    	require
    		5 <= a_size and a_size <= 8
    	do
    		create board.make (a_size)
    	end

	board: BOARD


feature -- message
	message: STRING

	set_message(a_message: STRING)
		do
			message := a_message
		end

feature -- out
	reset
			-- Reset model state.
		do
			make
		end

	out : STRING
			-- obtain board layout from board.out
		do
			create Result.make_from_string ("  " + message + ":")
			if message ~ "ok" and board.started then
				Result.append ("%N")
				Result.append (board.out)
			end

		end

end




