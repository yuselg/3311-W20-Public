note
	description: "Summary description for {OPERATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class OPERATION create
	make
feature {NONE}
	make (a_action: like action;
	         a_reaction: like reaction)
		do
			action := a_action
			reaction := a_reaction
		end

feature
	execute
		do
			action.call
		end

	action: PROCEDURE

	reaction: PROCEDURE
end


