note
	description: "[
		snooker table with red and blue ball
		can move red and blue balls with a delta impulse
		terminates if a ball is moved to a pocket.
	]"
	author: "JSO"
class 
	SNOOKER_TABLE
inherit
	CONSTANTS
create 
	make
feature {NONE} -- Initialization

	make (a_blue, a_red: BALL_POINT)
			-- Initialization for Current.
		require
				a_blue /~ a_red
feature -- queries
	blue: BALL_POINT

	red: BALL_POINT

	pocket: BALL_POINT

	terminated: BOOLEAN
			-- game terminates when either ball is in pocket
		ensure
				Result = (blue ~ pocket or red ~ pocket)
		end
	
feature -- commands

	impulse_blue (delta: TUPLE2)
			-- move blue ball on table by delta
		require
			delta_safe: blue.safe (blue.x + delta.x, blue.y + delta.y)
			status: not terminated
			not_red: red /~ {BALL_POINT}.t2ball 
				(create {TUPLE2}.make_from_tuple 
					([blue.x + delta.x, blue.y + delta.y]))
		ensure
			new_blue_x: blue.x ~ old blue.x + delta.x
			new_blue_y: blue.y ~ old blue.y + delta.y
			unchanged: red ~ old red
		end

	impulse_red (delta: TUPLE2)
			-- move red ball on table by delta
		require
			delta_safe: red.safe (red.x + delta.x, red.y + delta.y)
			status: not terminated
			not_blue: -- delta does not take us to red ball point
				blue /~ {BALL_POINT}.t2ball ([red.x + delta.x, red.y + delta.y])

		ensure
			new_red_x: red.x ~ old red.x + delta.x
			new_red_y: red.y ~ old red.y + delta.y
			unchanged: blue ~ old blue
		end
	
feature --  multi move blue ball
	maximum: detachable TUPLE2

	calculated: BOOLEAN -- max was calculated

	multi_move_blue (a: ARRAY [TUPLE2])
			-- many blue ball moves, if posible,
			-- and save the maximum move
		require
				not terminated
				a.count >= 1
		local
			i: INTEGER_32
			old_blue: like blue
			l_delta: TUPLE2
			l_stop: BOOLEAN
		do
			create maximum.make (Zero, Zero)
			calculated := True
			old_blue := blue.deep_twin
			from
				i := a.lower
			until
				i > a.count or l_stop
			loop
				l_delta := a [i]
				if safe (l_delta) then
					impulse_blue (l_delta)
					if attached maximum as l_max 
						and then l_max < l_delta 
					then
						maximum := l_delta
					end
				else
					l_stop := True
					calculated := False
				end
				i := i + 1
			end
			if l_stop then
				blue := old_blue
				maximum := Void
			end
		ensure
			max_not_calculated:
				not calculated implies maximum = Void
			max_calculated:
				  calculated
				implies
				  attached maximum as max
				  and then a.has (max)
				  and then (across a is delta all
					      max >= delta
					    end)
		end
	
feature {NONE} -- implementation

	safe (delta: TUPLE2): BOOLEAN
			-- is it safe to move blue by delta?
		local
			new_blue: like blue
		do
			create new_blue.make (blue.x + delta.x, blue.y + delta.y)
			Result := blue.safe (blue.x + delta.x, blue.y + delta.y) 
				and new_blue /~ red and not terminated
		end
	
invariant
no_crash: 
	red /~ blue
top_right_terminating_pocket: 
	pocket ~ {BALL_POINT}.t2ball (create {TUPLE2}.make_from_tuple ([Width, Length]))

	not calculated = (maximum = Void)

end -- class SNOOKER_TABLE
			