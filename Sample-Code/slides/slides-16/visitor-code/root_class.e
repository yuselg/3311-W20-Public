note
	description	: "System's root class"

class
	ROOT_CLASS
inherit
	ES_TEST

create
	make

feature -- Initialization


	make
			-- Creation procedure.
		do
--			make_test
			add_boolean_case (agent test_evaluator_with_constant_341)
			add_boolean_case (agent test_evaluator_with_plus)
			add_boolean_case (agent test_infix_printer_with_constant)
			add_boolean_case (agent test_infix_printer_with_plus)
			show_browser
			run_espec
		end

feature -- Test cases Visitor Evaluator

	test_evaluator_with_constant_341: BOOLEAN
			local
				constant341: CONSTANT
				evaluator: EVALUATOR
			do
				comment("test_evaluator_with_constant_341")
				create constant341.make (341)
				check
					constant341.value = 341
				end
				create evaluator
				constant341.accept (evaluator)
				Result := evaluator.value = constant341.value
			end


	test_evaluator_with_plus: BOOLEAN
			local
				constant341, constant2: CONSTANT
				plus: ADDITION
				evaluator: EVALUATOR
			do
				comment("test_evaluator_with_plus")
				create constant341.make (341)
				create constant2.make (2)
				create plus.make (constant341, constant2)
				create evaluator
				plus.accept (evaluator)
				Result := evaluator.value = 343
			end

feature -- Test cases Visitor Infix Printer

	test_infix_printer_with_constant: BOOLEAN
			local
				constant341: CONSTANT
				printer: INFIX_PRINTER
			do
				comment("test_infix_printer_with_constant")
				create constant341.make (341)
				create printer.make
				constant341.accept (printer)
				Result := equal(printer.string, "341")
			end

	test_infix_printer_with_plus: BOOLEAN
			local
				constant341, constant2: CONSTANT
				plus: ADDITION
				printer: INFIX_PRINTER
			do
				comment("test_infix_printer_with_plus")
				create constant341.make (341)
				create constant2.make (2)
				create plus.make (constant341, constant2)
				create printer.make
				plus.accept (printer)
				Result := equal(printer.string, "(341 + 2)")
			end

end -- class ROOT_CLASS
