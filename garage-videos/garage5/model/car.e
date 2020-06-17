note
	description: "[
		Repersentation of a car having a model, 
		year and odometer reading.
		]"
	author: "JSO"

class
	CAR[G -> attached ANY]
inherit
	ANY
		redefine is_equal end

	DEBUG_OUTPUT
		undefine is_equal end

create
	make
feature {NONE} -- constructor

	make(a_model: G; a_year: INTEGER; a_miles: like odometer)
			-- Initialize a new car with `a_model`, `a_year`, and an odometer read `a_miles`.
		require
			consistent_year: a_year >= 1900
			positive_miles: a_miles >= 0
		do
			model := a_model
			year := a_year
			odometer := a_miles
		ensure
			proper_initialization:
					model ~ a_model
				and	year = a_year
				and odometer = a_miles
		end

feature -- queries
	model: G
	year: INTEGER
	odometer: INTEGER

	is_equal(other: like Current): BOOLEAN
			-- Is current car equal to `other`?
		do
			Result :=
						model ~ other.model
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
						model ~ old model.deep_twin
				and 	year = old year
		end

feature -- out
	debug_output: STRING
		do
			Result := model.out
				+ "," + year.out
				+ "," + odometer.out
		end

invariant
	car_year:
		year >= 1900

	mileage:
		odometer >= 0
end
