note
	description: "A position on a snooker table 356.9 cm by 177.8cm."
	author: "JSO"

class 
	BALL_POINT

inherit

	CONSTANTS
		redefine
			out,
			is_equal
		end

	DEBUG_OUTPUT
		redefine
			out,
			is_equal
		end

create 
	make,
	make_from_tuple2

convert -- safe type conversion

	make_from_tuple2 ({TUPLE2})

feature {NONE} 

	make (a_x, a_y: DECIMAL)
			-- create snooker ball at position [a_x, a_y]
		require
			x_precondition: Zero <= a_x and a_x <= Width
			y_precondition: Zero <= a_y and a_y <= Length
		ensure
				x = a_x and y = a_y
		end

	make_from_tuple2 (t: TUPLE2)
			-- create a snooker ball at position `t`
		require
				safe (t.x, t.y)
		ensure
				x = t.x and y = t.y
		end
	
feature -- queries

	x: DECIMAL
			-- x-coordinate of the ball

	y: DECIMAL
			-- y-coordinate of the ball

	safe (a_x, a_y: DECIMAL): BOOLEAN
			-- is position [a_x, a_y] within the dimensions 
			-- of the snooker table?
		ensure
			class  -- static
			Result = (Zero <= a_x 
				and a_x <= Width 
				and Zero <= a_y 
				and a_y <= Length)
		end

	
	
	t2ball (t: TUPLE2): like Current
			-- convert tuple `t` to a ball position
		require
				safe (t.x, t.y)
		ensure
				class
				Result ~ create {BALL_POINT}.make_from_tuple2 (t)
		end
	
feature -- comparison

	is_equal (other: like Current): BOOLEAN
			-- Is other attached to an object considered
			-- equal to current object?
		ensure then
				Result = (x ~ other.x and y ~ other.y)
		end

	distance (other: like Current): TUPLE2
			-- distance as a tuple from  current ball 
			-- to position of other ball
		ensure
			Result ~ 
			   create {TUPLE2}.make_from_tuple ([other.x - x, other.y - y])
		end
	
feature -- commands

	cue_delta (d_x, d_y: DECIMAL)
			-- move ball from current position by a delta [d_x, d_y]
		require
			x_cue_precondition: Zero <= x + d_x and x + d_x <= Width
			y_cue_precondition: Zero <= y + d_y and y + d_y <= Length
		ensure
				x ~ (old x + d_x)
				y ~ (old y + d_y)
		end
	
feature -- out

	out: STRING_8
			-- New string containing terse printable representation
			-- of current object
		do
			Result := "(" + x.precise_out + "," + y.precise_out + ")"
		end

	debug_output: STRING_8
		-- String that should be displayed in debugger to represent Current.
		do
			Result := out
		end
	
invariant
	y_constraint: 
		Zero <= y and y <= Length
	x_constraint: 
		Zero <= x and x <= Width

end -- class BALL_POINT