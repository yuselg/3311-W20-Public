class
	MULTIPLICATION

	-- Products of expressions.

inherit

	EXPRESSION

create
	make

feature

	left, right: EXPRESSION
			-- The sub-expressions

	make (l, r: EXPRESSION)
			-- Create as `l' times `r'.
		do
			left := l
			right := r
		end

	accept (visitor: VISITOR)
		do
			visitor.visit_multiplication (Current)
		end

end -- class MULTIPLICATION
