note
	description: "[
		Repersentation of a car having a model, 
		year and odometer reading.
		]"
	author: "JSO"

class
	CAR[G]

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

feature -- commands
	update_odometer(a_mileage: INTEGER)
			-- Increase the odometer read by `a_mileage`.
		require
			positive_increase: a_mileage > 0
		do
--			odometer :=  a_mileage -- wrong implementation
			odometer := odometer + a_mileage
			year := a_mileage
			-- Q1: Is the implementatio correct w.r.t. the current postcondition? No
			-- Q2: Is the current postcondition complete to prevent other faulty implementation?
		ensure
			correct_update:
				odometer = old odometer + a_mileage
			others_unchanged:
				year = old year
		end

invariant
	valid_car_year:
		year >= 1900

	valid_mileage:
		odometer >= 0
end
