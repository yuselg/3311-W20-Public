class
	CONSTANT
inherit
	EXPRESSION
create
	make

feature
	value: INTEGER
			-- The value of this constant.

	make (v: INTEGER)
			-- Initialise to `v'.
		do
			value := v
		end

	accept (visitor: VISITOR)
			-- Traverse with `visitor'.
		do
			visitor.visit_constant (Current)
		end

end -- class CONSTANT
