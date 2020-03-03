note
	description: "Summary description for {TAX_PAYER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class TAX_PAYER create
	make
feature {NONE} -- Constructor
	make(a_name:STRING; a_id: INTEGER)
		do
			name := a_name
			id := a_id
		end

feature
	name: STRING
	id: INTEGER
end

