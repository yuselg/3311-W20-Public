note
	description: "Summary description for {ANSWER}."
	author: "JSO"
	date: "2020-03-04"

class
	ANSWER

create
	make

feature -- Constructor
	make
		do
			create value.make_empty
		end

feature
	value: STRING
		-- some answer

	set_value (v: STRING)
		do
			value := v
		end

end
