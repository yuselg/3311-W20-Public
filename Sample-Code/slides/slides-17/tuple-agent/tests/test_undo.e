note
	description: "Summary description for {TEST_UNDO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_UNDO
inherit
	ES_TEST
create
	make
feature

	make
		do
			text := ""
			create {ARRAYED_LIST[OPERATION]}history.make (10)
			add_boolean_case (agent t0)
			add_boolean_case (agent t1)
		end

feature -- text editor
	text: STRING

	num_chars: INTEGER
		-- number of characters
		-- of last insertion in `text'



	insert(s: STRING; i: INTEGER)
			-- put line `s' i times into `text'
		do
			across 1 |..| i as cr loop
				text.append (s + "%N")
			end
			num_chars := (s.count + 1)*i
		end

	reverse_insert(i: INTEGER)
			-- remove the last `i' lines in text
		do
			text.remove_tail (num_chars)
		end

	history: LIST[OPERATION]

feature -- tests
	t0: BOOLEAN
		do
			comment("t0: test put")
			insert("first line", 2)
			insert("second line",3)
			print("initial text: %N" + text)
			reverse_insert (num_chars)
			print("final text: %N" + text)
			Result := text.count = 22
		end

	t1: BOOLEAN
		local
			o1, o2: OPERATION
		do
			text := ""

			-- store first text insert
			create o1.make (agent insert("first line", 2),
						agent reverse_insert (num_chars))
			history.extend (o1)
			history.forth
			o1.execute -- now execute it

			-- store second text insert
			create o2.make (agent insert("second line", 3),
			            agent reverse_insert (num_chars))
			history.extend (o2)
			history.forth
			o2.execute -- now execute it

			-- now undo second insert
			history.item.reaction.call
			history.back

			-- now redo second insert
			history.forth
			history.item.action.call

			Result := True
		end

feature -- utilities
	c(s:STRING) do end
end
