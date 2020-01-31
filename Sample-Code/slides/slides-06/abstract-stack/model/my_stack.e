note
	description: "[
		MY_STACK[G] inherits complete contracts 
		  from ABSTRACT_STACK[G].
		Implemented with a LINKED_LIST[G]. 
			top of the stack is first element of list;
			model[1] ~ implementation[1]
	]"
	author: "JSO"
	date: "2020-01-26"

class
	MY_STACK [G -> attached ANY]
inherit

	ANY
		undefine is_equal end

	ABSTRACT_STACK [G]
		redefine
			count,
			make,
			model,
			top,
			push,
			pop
		end

create
	make

feature {NONE} -- creation

	implementation: LINKED_LIST [G]
		-- implementation of stack as a linked list

	make
			-- create an empty stack
		do
			create implementation.make
			implementation.compare_objects
			create imp.make_empty
		end

feature -- model

	model: SEQ [G]
			-- abstraction function
		do
			create Result.make_empty
			from
				implementation.start
			until
				implementation.after
			loop
				Result.append (implementation.item)
				implementation.forth
			end
		ensure then
			consistency: -- ∀i ∈ 1..count: Result[i] = imp[i]
				across 1 |..| count is i all
					Result [i] ~ implementation [i]
				end
		end

feature -- Queries

	count: INTEGER
			-- number of items in stack
		do
			Result := implementation.count
		end

	top: G
		do
			Result := implementation.first
		end

feature -- Commands

	push (x: G)
			-- push `x' on to the stack
		do
			implementation.put_front (x)
		end

	pop
		do
			implementation.start
			implementation.remove
		end

invariant
	same_count:
		model.count = implementation.count

end
