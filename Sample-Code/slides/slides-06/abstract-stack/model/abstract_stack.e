note
	description: "[
		Infinite stack API,
		fully contracted using Mathmodels SEQ[G]
		Value semantics, attached.
	]"

class ABSTRACT_STACK [G -> attached ANY] inherit
	ANY
		redefine is_equal end
create
	make
feature {NONE}
	make
		do
			create imp.make_empty
		end

	imp: SEQ[G]

feature -- model

	model: SEQ [G]
			-- implemented with a sequence
		do
			Result := imp
		end

feature -- Queries
	is_equal (other: like Current): BOOLEAN
		do
			Result := model ~ other.model
		ensure then
			Result = (model ~ other.model)
		end

	count: INTEGER
			-- number of items in stack
		do
			Result := model.count
		ensure
			Result = model.count
		end

	is_empty: BOOLEAN
			-- Is this stack empty?
		do
			Result := count = 0
		ensure
			Result = (count = 0)
		end

	top: G
			-- top of stack
		require
			not is_empty
		do
			Result := model[1]
		ensure
			Result ~ model.first
		end

feature -- Commands
	push (x: G)
			-- push `x' on to the stack
		do
			imp.prepend (x)
		ensure
			pushed_othewise_unchanged:
				model ~ ((old model.deep_twin) |<- x)
		end

	pop
			-- pop top of stack
		require
			not is_empty
		do
			imp.remove (1)
		ensure
			model ~ old model.deep_twin.tail
		end

invariant
	count >= 0
end
