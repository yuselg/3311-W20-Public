note
	description: ""
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PLAY
inherit
	ETF_PLAY_INTERFACE
		redefine play end
create
	make
feature -- command

	play(size: INTEGER_64)
		require else
			play_precond(size)
		local
			square: SQUARE
    	do
			-- setup board
			if not model.board.started then
				model.make_board (size)
				model.board.set_started
				create square.make (size,size)
				model.set_message ("ok")
			else
				model.set_message("game already started")
			end

			-- push
			etf_cmd_container.on_change.notify ([Current])
    	end

end
