deferred class
   VISITOR -- Visitors for traversing expression trees.
   
feature
   visit_constant (c: CONSTANT)
      deferred
      end

   visit_addition (a: ADDITION)
      deferred
      end

   visit_subtraction (s: SUBTRACTION)
      deferred
      end

   visit_multiplication (m: MULTIPLICATION)
      deferred
      end

end -- VISITOR
