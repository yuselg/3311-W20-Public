class
   
   POSTFIX_PRINTER
   
inherit
   VISITOR
   
create
   make
   
feature {ANY} -- Queries
   
   string: STRING
	 -- The formatted expression.
   
feature {NONE} -- Creation
   
   make
	 -- Initialise.
      do
	 string := clone ("")
      end
   
feature {ANY} -- Commands
   
   visit_constant (c: CONSTANT)
	 -- Process a constant expression.
      do
	 string.append (c.value.out)
	 string.append (" ")
      end 
   
   visit_addition (a: ADDITION)
	 -- Process an addition expression.
      do
	 a.left.accept (Current)
	 a.right.accept (Current)
	 string.append ("+ ")
      end 
   
   visit_subtraction (s: SUBTRACTION)
	 -- Process a subtraction expression.
      do
	 s.left.accept (Current)
	 s.right.accept (Current)
	 string.append ("- ")
      end 
   
   visit_multiplication (m: MULTIPLICATION)
	 -- Process a multiplication expression.
      do
	 m.left.accept (Current)
	 m.right.accept (Current)
	 string.append ("* ")
      end 
   
end -- class POSTFIX_PRINTER
