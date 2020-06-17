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
		do
			model := a_model
			year := a_year
			odometer := a_miles
		ensure
			proper_initialization:
						model ~ a_model
				and	year = a_year
				and 	odometer = a_miles
		end

feature -- queries
	model: G
	year: INTEGER
	odometer: INTEGER

invariant
	valid_car_year:
		year >= 1900

	valid_mileage:
		odometer >= 0

end
