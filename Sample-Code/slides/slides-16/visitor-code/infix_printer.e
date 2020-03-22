class
	INFIX_PRINTER

inherit

	VISITOR

create
	make

feature {ANY} -- Queries

	string: STRING
			-- The formatted expression.

feature {NONE} -- Creation

	make
			-- Initialise to empty
		do
			string := ""
		end

feature {ANY} -- Commands

	visit_constant (c: CONSTANT)
			-- Process a constant expression.
		do
			string.append (c.value.out)
		end

	visit_addition (a: ADDITION)
			-- Process an addition expression.
		do
			string.append ("(")
			a.left.accept (Current)
			string.append (" + ")
			a.right.accept (Current)
			string.append (")")
		end

	visit_subtraction (s: SUBTRACTION)
			-- Process a subtraction expression.
		do
			string.append ("(")
			s.left.accept (Current)
			string.append (" - ")
			s.right.accept (Current)
			string.append (")")
		end

	visit_multiplication (m: MULTIPLICATION)
			-- Process a multiplication expression.
		do
			string.append ("(")
			m.left.accept (Current)
			string.append (" * ")
			m.right.accept (Current)
			string.append (")")
		end

end -- class INFIX_PRINTER
