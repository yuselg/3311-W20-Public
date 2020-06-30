note
	description: "[
		Repersentation of a car having a make, 
		year and odometer reading. 
		The `make` of a car is a generic parameter 
			(allonwing for abstraction over types)
		The `id` of a car is also a generic parameters
		]"
	author: "JSO"

class
	CAR[ID -> COMPARABLE, MAKE -> attached ANY]
inherit
	ANY
		redefine is_equal end

	DEBUG_OUTPUT
		undefine is_equal end

create
	add_car
feature {NONE} -- constructor

	add_car(a_id: ID; a_model: MAKE; a_year: INTEGER; a_miles: like odometer)
			-- Initialize a new car with `a_model`, `a_year`, and an odometer read `a_miles`.
		require
			consistent_year: a_year >= 1900
			positive_miles: a_miles >= 0
		do
			make := a_model
			year := a_year
			odometer := a_miles
			id := a_id
		ensure
			proper_initialization:
				make ~ a_model
				year = a_year
				odometer = a_miles
				id ~ a_id
		end

feature -- queries
	id : ID
	make: MAKE
	year: INTEGER
	odometer: INTEGER

	is_equal(other: like Current): BOOLEAN
			-- Is current car equal to `other`?
		do
			Result :=
						make ~ other.make
				and 	year = other.year
				and 	odometer = other.odometer
		end

feature -- commands

	update_odometer(a_mileage: INTEGER)
			-- Increase the odometer read by `a_mileage`.
		require
			positive_increase: a_mileage > 0
		do
			odometer :=  odometer + a_mileage
		ensure
			correct_update:
				odometer = old odometer + a_mileage
			others_unchanged:
						make ~ old make.deep_twin
				and 	year = old year
		end

feature -- out
	debug_output: STRING
		do
			Result := make.out
				+ "," + year.out
				+ "," + odometer.out
		end

invariant
	car_year:
		year >= 1900

	mileage:
		odometer >= 0
end
