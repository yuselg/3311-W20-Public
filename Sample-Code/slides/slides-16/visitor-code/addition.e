class
	ADDITION
inherit
	EXPRESSION
create
	make

feature

	left, right: EXPRESSION
			-- The sub-expressions

	make (l, r: EXPRESSION)
			-- Initialise to `l' plus `r'.
		do
			left := l
			right := r
		end

	accept (visitor: VISITOR)
			-- Traverse with `visitor'.
		do
			visitor.visit_addition (Current)
		end

end -- class ADDITION
