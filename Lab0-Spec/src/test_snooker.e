note
	description: "[
		Test examples with arrays and regular expressions.
		First test fails as Result is False by default.
		Write your own tests.
		Included libraries:
			base and extension
			Espec unit testing
			Mathmodels
			Gobo structures
			Gobo regular expressions
		]"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision 19.05$"

class
	TEST_SNOOKER

inherit

	ES_TEST
	CONSTANTS

create
	make

feature {NONE} -- Initialization

	make
			-- initialize tests
		do
			-- test POINT
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)

			-- test snooker table
			add_boolean_case (agent t5)

			-- test POINT violation cases
			add_violation_case_with_tag ("x_precondition", agent t10)
			add_violation_case_with_tag ("y_precondition", agent t11)
			add_violation_case_with_tag ("y_cue_precondition", agent t12)

			-- test snooker violation cases
			add_violation_case_with_tag ("delta_safe", agent t20)
			add_violation_case_with_tag ("not_red", agent t21)
		end


feature -- tests


	t1: BOOLEAN
		local
			p1, p2:  BALL_POINT
		do
			comment ("t1: create point; then cue delta")
			-- create point p1
			create p1.make ("10.8", "7.6")
			Result := p1.x ~ "10.8" and p1.y ~ "7.6"
			check Result end
			-- alternative way to create a point p2
			p2 := {BALL_POINT}.t2ball (["140.8", "19.9"])
			Result := p1 /~ p2
			check Result end
			create p2.make ("10.8", "7.6")
			Result := p1 ~ p2
			check Result end
		end

	t2: BOOLEAN
		local
			p1, p2:  BALL_POINT
		do
			comment ("t2: create two unequal points")
			create p1.make ("10.7", "7.6")
			create p2.make ("177.8", "356.9")
			p1.cue_delta ("167.1", "349.3")
			Result := p1 ~ p2
			check Result end
		end

	t3: BOOLEAN
		local
			p, pocket:  BALL_POINT
			distance: TUPLE2
		do
			comment ("t3: distance from a point to a pocket")
			create pocket.make (width, length)
			create p.make ("10.8", "7.6")
--			assert_equal ("distance to pocket",  "", p1.distance(pocket))
			Result := p.distance(pocket) ~ ["167", "349.3"]
			check Result end
--			assert_equal ("distance to pocket", "" , pocket.distance(p1))
			Result := pocket.distance(p) ~ ["-167", "-349.3"]
			check Result end
			distance := ["-167", "-349.3"] -- not a snooker point
			Result := distance ~ pocket.distance(p)
		end

feature -- tests for SNOOKER_TABLE
	t5: BOOLEAN
		local
			table: SNOOKER_TABLE
			blue, red, new: BALL_POINT
			delta: TUPLE2
		do
			comment ("t5: test snooker table")
			create blue.make ("88.9", "178.45")
			create red.make ("50", "100")
			create table.make (blue, red)
			Result := not table.terminated
				and table.blue.x ~ "88.9" and table.blue.y ~ "178.45"
			delta := ["1", "1"]
			table.delta_blue (delta)
			Result := table.blue ~ {BALL_POINT}.t2ball (["89.9", "179.45"])
			check Result end
		end

feature -- violation cases
	t10
		local
			p: BALL_POINT
		do
			comment ("t10: violate x_precondition")
			-- make sure that you write a precondition that
			-- prevents a violation of the invariant
			create p.make ("-0.01", "356.9")
		end

	t11
		local
			p: BALL_POINT
		do
			comment ("t11: violate y_precondition")
			-- make sure that you write a precondition that
			-- prevents a violation of the invariant
			create p.make ("177.8", "356.91")
		end

	t12
		local
			p: BALL_POINT
		do
			comment ("t12: violate with cue delta")
			-- make sure that you write a precondition that
			-- prevents a violation of the invariant
			create p.make ("177.8", "356.9")
			p.cue_delta ("0", "0.00001")
		end

feature -- snooker table violation cases
	t20
		local
			table: SNOOKER_TABLE
			blue, red: BALL_POINT
			delta: TUPLE2
		do
			comment ("t20: test snooker table violate delta safe impulse")
			create blue.make ("88.9", "178.45")
			create red.make ("50", "100")
			create table.make (blue, red)
			delta := ["200", "300"]
			table.delta_blue (delta)
		end

	t21
		local
			table: SNOOKER_TABLE
			blue, red: BALL_POINT
			delta: TUPLE2
		do
			comment ("t21: test snooker table violate not red impulse")
			create blue.make ("88.9", "178.45")
			create red.make ("50", "100")
			create table.make (blue, red)
			delta := ["-38.9", "-78.45"]
			table.delta_blue (delta)
		end
end
