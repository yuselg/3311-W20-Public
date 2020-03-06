note
	description: "Move King command"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVE_KING
inherit
	ETF_MOVE_KING_INTERFACE
		redefine move_king end
create
	make
feature -- command
	move_king(square: TUPLE[x: INTEGER_64; y: INTEGER_64])
		require else
			move_king_precond(square)
		local
			new_square: SQUARE
			old_square: SQUARE
			l_x,l_y: INTEGER
			op: MOVE_KING
			moves: ARRAY[SQUARE]
    	do

			-- create move op
			old_square := model.board.king_position
			l_x := square.x.as_integer_32
			l_y := square.y.as_integer_32
			create new_square.make (l_x, l_y)
			create op.make (new_square)
			moves := op.moves (old_square.x, old_square.y)
			if moves.has (new_square) then
				model.board.history.extend_history (op)
				model.set_message ("ok")
				op.execute
			else
				model.set_message ("invalid move")
			end

			-- push
			etf_cmd_container.on_change.notify ([Current])
    	end

end
