note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_UNDO
inherit
	ETF_UNDO_INTERFACE
		redefine undo end
create
	make
feature -- command
	undo
    	do

			if model.board.history.after then
				model.board.history.back
			end

			if model.board.history.on_item then
				model.board.history.item.undo
				model.board.history.back


				model.set_message ("ok")
			else
				model.set_message ("no more to undo")
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
