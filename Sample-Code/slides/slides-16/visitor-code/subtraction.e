class

   SUBTRACTION

      -- Sums of expressions.

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
--	 visitor.visit_addition (Current)
		visitor.visit_subtraction (Current)
      end

end

