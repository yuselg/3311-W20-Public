note
	description: "Test STACK[G] based on Mathnodels."
	author: "JSO"

class
	TEST_STACK
inherit
	ES_TEST

create
	make

feature {NONE} -- Initialization

	make
			-- run tests
		do
			add_boolean_case (agent t0)
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
		end

feature -- tests

	t0: BOOLEAN
		local
			s1, s1_old, s2: SEQ[STRING]
		do
			comment("t0: empty sequence, append and prepend for stack model")
			create s1.make_empty
			Result := s1.count = 0 and s1.is_empty
			check Result end
			create s1.make_from_array (<<"b", "c", "d">>)
			create s2.make_from_array (<<"a", "b", "c", "d", "e">>)
			Result := s1 /~ s2 and s1.count = 3
			check Result end
			s1_old := s1.deep_twin
			--append "e"
			s1.append ("e")
			Result := s1 ~ s1_old |-> "e"
			check Result end  -- s1 = (old s1) ▷ "e
			-- prepend "e"
			s1.prepend ("a")
			Result := s1 ~ (s1_old |-> "e") |<- "a"
			check Result end -- s1 = ((old s1) ▷ "e") ◁ "a"
			Result := s1 ~ s2 and s1.first ~ "a" and s1.last ~ "e"
			check Result end
		end
	t1: BOOLEAN
		local
			stk: ABSTRACT_STACK[STRING]
			model: SEQ[STRING]
		do
			comment("t1: test model of abstract stack")
			create stk.make
			stk.push("hello")
			stk.push("goodbye")
			stk.push("adios")
			Result := stk.count = 3 and stk.top ~ "adios"
			check Result end
			assert_equal ("model",
				stk.model.out,
				"< adios, goodbye, hello >")
			stk.pop
			Result := stk.count = 2 and stk.top ~ "goodbye"
			check Result end
			assert_equal ("model",
				stk.model.out,
				"< goodbye, hello >")
		end

	t2: BOOLEAN
		local
			stk1, stk2: ABSTRACT_STACK[STRING]
		do
			comment("t2: test abstract stack for property pop(push(stk,x)) = stk")
			create stk1.make
			Result := stk1.count = 0 -- empty
			check Result end
			---
			stk1.push("hello")
			Result := stk1.count = 1 and stk1.top ~ "hello"
			check Result end
			stk1.push("goodbye")
			Result := stk1.count = 2 and stk1.top ~ "goodbye"
			check Result end
			stk2 := stk1.deep_twin

			-- push, then pop produces original stack
			stk1.push("adios")
			Result := stk1.count = 3 and stk1.top ~ "adios"
			check Result end
			stk1.pop
			Result := stk1.is_equal (stk2)
			check Result end
			--
			stk1.pop
			Result := stk1.count = 1 and stk1.top ~ "hello"
		end

	t3: BOOLEAN
		local
			stk1, stk2: MY_STACK[STRING]
		do
			comment("t3: test M_STACK[STRING], pop and push")
			create stk1.make
			Result := stk1.count = 0 -- empty
			check Result end
			---
			stk1.push("hello")
			Result := stk1.count = 1 and stk1.top ~ "hello"
			check Result end
			stk1.push("goodbye")
			Result := stk1.count = 2 and stk1.top ~ "goodbye"
			check Result end
			stk2 := stk1.deep_twin

			-- push, then pop produces original stack
			stk1.push("adios")
			Result := stk1.count = 3 and stk1.top ~ "adios"
			check Result end
			stk1.pop
			Result := stk1.is_equal (stk2)
			check Result end
			--
			stk1.pop
			Result := stk1.count = 1 and stk1.top ~ "hello"
		end



end
