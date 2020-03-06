note
	description: "Summary description for {TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CHESS_MOVES
inherit
	ES_TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			add_boolean_case (agent test_bishop_moves)
			add_boolean_case (agent test_rook_moves)
		end

feature -- quieries

	KNIGHT	: CHARACTER 	= 'N'
	KING	: CHARACTER 	= 'K'
	BISHOP	: CHARACTER 	= 'B'
	ROOK	: CHARACTER 	= 'R'

	directions_of_player (player: CHARACTER): ARRAY[TUPLE[x: INTEGER; y: INTEGER]]
			-- Given the type of `player', return all possible directions of moves.
			-- e.g., [ 1,  2] means move to right by 1 and move up   by 2
			-- e.g., [-1, -2] means move to left  by 2 and move down by 2
			-- Notice that this query does not consider the player's current position and the board size.
			-- It is expected that the return value of this query is further filtered out
			-- based on the player's current position and the board size.
		require
			player = KNIGHT or player = KING or player = BISHOP or player = ROOK
		local
			x, y: INTEGER
		do
			create Result.make_empty
			if player = KNIGHT then
				Result := <<[1, 2], [ 1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]>>
			elseif player = KING then
				Result := <<[1, 0], [-1,  0], [ 0, 1], [ 0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]>>
			elseif player = BISHOP then
				across 1 |..| 7 as i loop
				across 0 |..| 1 as x_sign loop
				across 0 |..| 1 as y_sign loop
					x := i.item
					if x_sign.item = 0 then
						x := x * -1
					end
					y := i.item
					if y_sign.item = 0 then
						y := y * -1
					end
					Result.force ([x, y], Result.count + 1)
				end
				end
				end
			elseif player = ROOK then
				across 0 |..| 7 as x_move loop
				across 0 |..| 7 as y_move loop
				across 0 |..| 1 as sign loop
					if x_move.item = 0 xor y_move.item = 0 then
						x := x_move.item
						y := y_move.item
						if x_move.item = 0 and sign.item = 0 then
							y := y * -1
						elseif y_move.item = 0 and sign.item = 0 then
							x := x * -1
						end
						Result.force ([x, y], Result.count + 1)
					end
				end
				end
				end
			end
		end

feature -- tests

	test_bishop_moves: BOOLEAN
		do
			comment("test_bishop_moves: all possible diagonal moves")
			Result := directions_of_player (BISHOP).count = 28
			check Result end

			Result :=
				create {SET[TUPLE[INTEGER, INTEGER]]}.make_from_array (directions_of_player (BISHOP))
				~
				create {SET[TUPLE[INTEGER, INTEGER]]}.make_from_array (
							<<	[ 1,  1], [ 2,  2], [ 3,  3], [ 4,  4], [ 5,  5], [ 6,  6], [ 7,  7],
								[-1,  1], [-2,  2], [-3,  3], [-4,  4], [-5,  5], [-6,  6], [-7,  7],
								[ 1, -1], [ 2, -2], [ 3, -3], [ 4, -4], [ 5, -5], [ 6, -6], [ 7, -7],
								[-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7]
							>>
				)
		end

	test_rook_moves: BOOLEAN
		do
			comment("test_rook_moves: all possible diagonal moves")
			Result := directions_of_player (ROOK).count = 28
			check Result end

			Result :=
				create {SET[TUPLE[INTEGER, INTEGER]]}.make_from_array (directions_of_player (ROOK))
				~
				create {SET[TUPLE[INTEGER, INTEGER]]}.make_from_array (
							<<	[ 1,  0], [ 2,  0], [ 3,  0], [ 4,  0], [ 5,  0], [ 6,  0], [ 7,  0],
								[ 0,  1], [ 0,  2], [ 0,  3], [ 0,  4], [ 0,  5], [ 0,  6], [ 0,  7],
								[-1,  0], [-2,  0], [-3,  0], [-4,  0], [-5,  0], [-6,  0], [-7,  0],
								[ 0, -1], [ 0, -2], [ 0, -3], [ 0, -4], [ 0, -5], [ 0, -6], [ 0, -7]
 							>>
				)
		end

end
