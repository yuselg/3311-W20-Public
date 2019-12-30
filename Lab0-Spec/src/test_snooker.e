note
	description: "[
		Test simple Snooker game.
		boolean tests and violation tests
	]"
	author: "JSO"
	ca_ignore: "CA085", "CA020"

class
	TEST_SNOOKER

inherit

	ES_TEST

	CONSTANTS

create
	make

feature --enable tests

	test_ball_point: BOOLEAN = True

	test_snooker: BOOLEAN = True

	test_ball_point_violation: BOOLEAN = True

	test_snooker_violation: BOOLEAN = True

feature {NONE} -- Initialization

	make
			-- initialize tests
		do
				-- test BALL_POINT
			if test_ball_point then
				add_boolean_case (agent t1)
				add_boolean_case (agent t2)
				add_boolean_case (agent t3)
			end

				-- test snooker table
			if test_snooker then
				add_boolean_case (agent t5)
				add_boolean_case (agent t6)
				add_boolean_case (agent t7)
				add_boolean_case (agent t8)
			end

				-- test BALL_POINT violation cases
			if test_ball_point_violation then
				add_violation_case_with_tag ("x_precondition", agent t10)
				add_violation_case_with_tag ("y_precondition", agent t11)
				add_violation_case_with_tag ("y_cue_precondition", agent t12)
			end

				-- test snooker violation cases
			if test_snooker_violation then
				add_violation_case_with_tag ("delta_safe", agent t20)
				add_violation_case_with_tag ("not_red", agent t21)
				add_violation_case_with_tag ("not_red", agent t22)
			end
		end

feature -- tests

	t1: BOOLEAN
		local
			p1, p2: BALL_POINT
		do
			comment ("t1: create a snooker ball point; then move it by delta")
				-- create point p1
			create p1.make ("10.8", "7.6")
			Result := p1.x ~ "10.8" and p1.y ~ "7.6"
			check
				Result
			end
				-- alternative way to create a point p2
			p2 := {BALL_POINT}.t2ball (["140.8", "19.9"])
			Result := p1 /~ p2
			check
				Result
			end
			create p2.make ("10.8", "7.6")
			Result := p1 ~ p2
			check
				Result
			end
		end

	t2: BOOLEAN
		local
			p1, p2: BALL_POINT
		do
			comment ("t2: create two unequal ball points; equality check")
			create p1.make ("10.7", "7.6")
			create p2.make ("177.8", "356.9")
			p1.cue_delta ("167.1", "349.3")
			Result := p1 ~ p2
			check
				Result
			end
		end

	t3: BOOLEAN
		local
			p, pocket: BALL_POINT
			distance: TUPLE2
		do
			comment ("t3: distance from a snooker ball point to the pocket")
			create pocket.make (width, length)
			sub_comment ("<br>" + "pocket is top-left: [117.8, 356.9]")
			create p.make ("10.8", "7.6")
				--			assert_equal ("distance to pocket",  "", p1.distance(pocket))
			Result := p.distance (pocket) ~ ["167", "349.3"]
			check
				Result
			end
			Result := pocket.distance (p) ~ ["-167", "-349.3"]
			check
				Result
			end
			distance := ["-167", "-349.3"] -- not a snooker point
			Result := distance ~ pocket.distance (p)
		end

feature -- tests for SNOOKER_TABLE

	t5: BOOLEAN
		local
			table: SNOOKER_TABLE
			blue, red: BALL_POINT
			delta: TUPLE2
		do
			comment ("t5: test snooker table with delta impulse to blue ball")
			create blue.make ("88.9", "178.45")
			create red.make ("50", "100")
			create table.make (blue, red)
			Result := not table.terminated and table.blue.x ~ "88.9" and table.blue.y ~ "178.45"
			delta := ["1", "1"]
			table.impulse_blue (delta)
			Result := table.blue ~ {BALL_POINT}.t2ball (["89.9", "179.45"])
			check
				Result
			end
		end

	t6: BOOLEAN
		local
			table: SNOOKER_TABLE
			blue, red: BALL_POINT
			delta: TUPLE2
		do
			comment ("t6: test snooker table with red impulse")
			create blue.make ("88.9", "178.45")
			create red.make ("50.1", "100.1")
			create table.make (blue, red)
			Result := not table.terminated and table.red.x ~ "50.1" and table.red.y ~ "100.1"
			delta := ["1.1", "1.1"]
			table.impulse_red (delta)
			Result := table.red ~ {BALL_POINT}.t2ball (["51.2", "101.2"])
			check
				Result
			end
		end

	t7: BOOLEAN
		local
			table: SNOOKER_TABLE
			blue, red: BALL_POINT
			max: TUPLE2
			a: ARRAY [TUPLE2]
		do
			comment ("t7: multi move of blue snooker ball with termination")
			create blue.make ("88.9", "178.45")
			create red.make ("50.1", "100.1")
			create table.make (blue, red)
			a := {ARRAY[TUPLE2]} <<["41", "67"], ["46", "68"], ["1.9", "43.45"]>>
			max := ["46", "68"]
			table.multi_move_blue (a)
			Result := table.blue ~ table.pocket and table.terminated and table.maximum ~ max
			check
				Result
			end
			assert_equal ("max is wrong", max, table.maximum)
		end

	t8: BOOLEAN
		local
			table: SNOOKER_TABLE
			blue, red, old_blue: BALL_POINT
			a: ARRAY [TUPLE2]
		do
			comment ("t8: multi move of blue and hit red. No termination")
			create blue.make ("88.9", "178.45")
			old_blue := blue.deep_twin
			create red.make ("50.1", "100.1")
			create table.make (blue, red)
			a := {ARRAY[TUPLE2]}<<["-1.5", "-8.45"], ["-16.7", "-69"], ["-20.6", "-0.9"]>>
				--			max := ["46","68"]
			table.multi_move_blue (a)
			Result := table.blue ~ old_blue and not table.terminated and table.maximum ~ Void
			check
				Result
			end
		end

feature -- violation cases

	t10
		local
			p: BALL_POINT
		do
			comment ("t10: violate x_precondition of a snooker ball out of table")
				-- make sure that you write a precondition that
				-- prevents a violation of the invariant
			create p.make ("-0.01", "356.9")
		end

	t11
		local
			p: BALL_POINT
		do
			comment ("t11: violate y_precondition of a snooker ball out of table")
				-- make sure that you write a precondition that
				-- prevents a violation of the invariant
			create p.make ("177.8", "356.91")
		end

	t12
		local
			p: BALL_POINT
		do
			comment ("t12: violate with impulse delta out of table")
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
			table.impulse_blue (delta)
		end

	t21
		local
			table: SNOOKER_TABLE
			blue, red: BALL_POINT
			delta: TUPLE2
		do
			comment ("t21: test snooker table: blue and red do not collide")
			create blue.make ("88.9", "178.45")
			create red.make ("50", "100")
			create table.make (blue, red)
			delta := ["-38.9", "-78.45"]
			table.impulse_blue (delta)
		end

	t22
		local
			table: SNOOKER_TABLE
			blue, red: BALL_POINT
		do
			comment ("t22: contract exception if blue set to hit red")
			create blue.make ("88.9", "178.45")
				--			old_blue := blue.deep_twin
			create red.make ("50.1", "100.1")
			create table.make (blue, red)
			table.impulse_blue (["-1.5", "-8.45"])
			table.impulse_blue (["-16.7", "-69"])
			table.impulse_blue (["-20.6", "-0.9"])
		end

end
