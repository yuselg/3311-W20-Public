class
	EVALUATOR
inherit
	VISITOR

feature
	value: INTEGER

	visit_constant (c: CONSTANT)
			-- Process a constant expression.
		do
			value := c.value
		end

	visit_addition (a: ADDITION)
			-- Process an addition expression.
		local
			left_evaluator, right_evaluator: EVALUATOR
		do
			create left_evaluator
			create right_evaluator
			a.left.accept (left_evaluator)
			a.right.accept (right_evaluator)
			value := left_evaluator.value + right_evaluator.value
		end

	visit_subtraction (s: SUBTRACTION)
			-- Process a subtraction expression.
		local
			left_evaluator, right_evaluator: EVALUATOR
		do
			create left_evaluator
			create right_evaluator
			s.left.accept (left_evaluator)
			s.right.accept (right_evaluator)
			value := left_evaluator.value - right_evaluator.value
		end

	visit_multiplication (m: MULTIPLICATION)
			-- Process a multiplication expression.
		local
			left_evaluator, right_evaluator: EVALUATOR
		do
			create left_evaluator
			create right_evaluator
			m.left.accept (left_evaluator)
			m.right.accept (right_evaluator)
			value := left_evaluator.value * right_evaluator.value
		end

end -- class EVALUATOR
