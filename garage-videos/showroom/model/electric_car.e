note
	description: "Summary description for {ELECTRIC_CAR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ELECTRIC_CAR[ID  -> COMPARABLE, MAKE -> attached ANY]

inherit
	CAR [ID, MAKE]
		redefine add_car end

create
	add_car

feature {NONE} -- constructor

	add_car(a_id: ID; a_model: MAKE; a_year: INTEGER; a_miles: like odometer)
		do
			make := a_model
			year := a_year
			odometer := a_miles
			id := a_id
			battery := 26  -- default kWh
		ensure then
			battery_set: battery = 26
		end

feature
	battery: INTEGER -- kWh kilowatt-hour

	upgrade_battery(a_new_battery: like battery)
			-- upgrade kilowatt hours
		require
			a_new_battery > battery + 10
		do
			battery := a_new_battery
		ensure
			battery = a_new_battery
		end

invariant
	valid_battry: battery >= 26

end
