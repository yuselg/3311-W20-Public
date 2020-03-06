note
	description: "[
		Abstract move of a chess piece, 
		e.g. King, Bishop, Rook, Knight etc.
		`directions` must be effected relative to the this piece,
		as well as execute, undo and redo.
		]"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MOVE

feature{NONE}

	board: BOARD
			-- access board via singleton
		local
			ma: ETF_MODEL_ACCESS
		once
			Result := ma.m.board
		end

feature  --deferred queries
	directions: ARRAY[TUPLE[x: INTEGER; y: INTEGER]]
			-- array of possoble directions
			-- to which this piece can move
		deferred
		end

feature -- queries
	valid (a_x, a_y: INTEGER): BOOLEAN
			-- Is this a valid position given borad size
		local
			n: INTEGER
		do
			n := board.size
			Result := (1 <= a_x and a_x <= n) and (1 <= a_y and a_y <= n)
		end

	moves (a_x, a_y: INTEGER): ARRAY [SQUARE]
			-- All possibe moves of this player from square [`a_x', `a_y']
		require
			valid (a_x, a_y)
		local
			xp, yp: INTEGER
			square: SQUARE
			j: INTEGER
		do
			create Result.make_empty
			j := 1

			across
				1 |..| directions.count as i
			loop
					-- position of knight after move
				xp := a_x + directions [i.item].x
				yp := a_y + directions [i.item].y
				if valid (xp, yp) and board.implementation [xp, yp] = '_' then
					create square.make (xp, yp)
					Result.force (square, j)
					j := j + 1
				end
			end
			Result.compare_objects
		end

feature -- deferred commands
	execute
		deferred
		end
	undo
		deferred
		end

	redo
		deferred
		end

end
