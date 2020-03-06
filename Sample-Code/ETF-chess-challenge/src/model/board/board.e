note
	description: "Chess board of varying sizes."
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	BOARD
inherit
	ANY
		redefine out end

create
	make

feature {NONE} -- create

	make(a_size: INTEGER)
			-- Initialization for `Current'.
		do
			size := a_size
			create implementation.make_filled ('_',size, size)
			create king_position.make (1, 1)
			implementation.put ('K', 1, 1)
			create bishop_position.make (size, size)
			implementation.put ('B', size, size)
			create history.make
		end

feature {MOVE} -- implementation
	implementation: ARRAY2[CHARACTER]
		-- implementation

feature  -- game started
	size: INTEGER
		-- size of board

    started: BOOLEAN
    	-- has the game started?

    set_started
    	do
        	started := True
    	end

feature -- positions

    king_position: SQUARE
    bishop_position: SQUARE

    move_king(a_square: SQUARE)
    	do
    		implementation.put ('_', king_position.x, king_position.y)
    		implementation.put ('K', a_square.x, a_square.y)
			king_position := a_square
    	end

    move_bishop(a_square: SQUARE)
    	do
    		-- To Do
    	end

feature -- history
 	history: HISTORY

feature -- out

    board_out: STRING
			-- representation of board
		do
			Result := "  "
			across 1 |..| size as h loop
				across 1 |..| size as w loop
					Result := Result + implementation[h.item,w.item].out
				end
				Result := Result + "%N  "
			end
			Result := Result.substring (1, Result.count-3)
		end

    out: STRING
			-- representation of board
		do
			Result := ""
			if started then
				Result := board_out
			end
		end
end
