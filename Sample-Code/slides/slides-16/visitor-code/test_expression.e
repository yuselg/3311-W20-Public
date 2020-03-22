class
   
   TEST_EXPRESSION
   
      -- Test program for the Visitor pattern implementation of 
      -- expression trees.
   
create
   make

feature -- JSO

   argument_count, exit_failure_code: INTEGER -- added JSO
   die_with_code (i: INTEGER) do end

feature {NONE} -- Attributes
   a, b, c: CONSTANT
   product: MULTIPLICATION
   sum: ADDITION
   
   evaluator: EVALUATOR
   prefix_printer: PREFIX_PRINTER
   infix_printer: INFIX_PRINTER
   postfix_printer: POSTFIX_PRINTER
   
feature {NONE} -- Creation
   
   make
	 -- Read four numbers a, b, c from the command line,
	 -- form the expression
      	 --     a + (b * c)
      	 -- and print it out in prefix, infix and postfix,
	 -- together with its value; then repeat with the 
	 -- expression
	 --    (a + b) * c
      do
--	 if argument_count /= 3 then
--	    io.put_string ("Usage: test_expression a b c%N")
--	    die_with_code (exit_failure_code)
--	 end
--	 !! a.make (argument (1).to_integer)
--	 !! b.make (argument (2).to_integer)
--	 !! c.make (argument (3).to_integer)
	 
--	 !! product.make (b, c)
--	 !! sum.make (a, product)
--	 
--	 !! prefix_printer.make
--	 !! infix_printer.make
--	 !! postfix_printer.make
--	 !! evaluator
--	 
--	 sum.accept (prefix_printer)
--	 sum.accept (infix_printer)
--	 sum.accept (postfix_printer)
--	 sum.accept (evaluator)
--	 
--	 io.put_string ("Prefix : " + prefix_printer.string + "%N")
--	 io.put_string ("Infix  : " + infix_printer.string + "%N")
--	 io.put_string ("Postfix: " + postfix_printer.string + "%N")
--	 io.put_string ("Value  : " + evaluator.value.to_string + "%N")
--	 
--	 !! sum.make (a, b)
--	 !! product.make (sum, c)
--	 
--	 !! prefix_printer.make
--	 !! infix_printer.make
--	 !! postfix_printer.make
--	 
--	 product.accept (prefix_printer)
--	 product.accept (infix_printer)
--	 product.accept (postfix_printer)
--	 product.accept (evaluator)
--	 
--	 io.put_string ("Prefix : " + prefix_printer.string + "%N")
--	 io.put_string ("Infix  : " + infix_printer.string + "%N")
--	 io.put_string ("Postfix: " + postfix_printer.string + "%N")
--	 io.put_string ("Value  : " + evaluator.value.to_string + "%N")
--	 
      end
   
end -- class TEST_EXPRESSION
