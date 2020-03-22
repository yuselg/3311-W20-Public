class
   
   PREFIX_PRINTER
   
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
	 string := clone ("")
      end
   
feature {ANY} -- Commands
   
   visit_constant (c: CONSTANT)
	 -- Process a constant expression.
      do
--	 string.append (c.value.to_string)
	 string.append (c.value.out)
      end 
   
   visit_addition (a: ADDITION)
	 -- Process an addition expression.
      do
	 string.append ("add (")
	 a.left.accept (Current)
	 string.append (", ")
	 a.right.accept (Current)
	 string.append (")")
      end 
   
   visit_subtraction (s: SUBTRACTION)
	 -- Process a subtraction expression.
      do
	 string.append ("sub (")
	 s.left.accept (Current)
	 string.append(", ")
	 s.right.accept (Current)
	 string.append (")")
      end 
   
   visit_multiplication (m: MULTIPLICATION)
	 -- Process a multiplication expression.
      do
	 string.append ("mul (")
	 m.left.accept (Current)
	 string.append (", ")
	 m.right.accept (Current)
	 string.append (")")
      end 
   
end -- class PREFIX_PRINTER
