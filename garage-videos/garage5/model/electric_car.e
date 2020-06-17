note
	description: "Summary description for {ELECTRIC_CAR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ELECTRIC_CAR[G -> attached ANY]

inherit
	CAR [G]
		redefine make end

create
	make

feature {NONE} -- constructor

	make(a_model: G; a_year: INTEGER; a_miles: like odometer)
		do
			model := a_model
			year := a_year
			odometer := a_miles
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
