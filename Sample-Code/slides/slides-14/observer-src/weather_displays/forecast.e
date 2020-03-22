note
	description: "Summary description for {FORECAST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FORECAST

inherit
	OBSERVER
create
	make

feature {NONE} --creation
	make(wd: WEATHER_DATA_SUBJECT)
		do
			weather_data := wd
			wd.attach (Current)
		end

feature

	current_pressure: REAL
	last_pressure: REAL

	weather_data: WEATHER_DATA_SUBJECT


	up_to_date_with_subject: BOOLEAN
			-- is this observer up to date with its subject
		do
			if current_pressure = weather_data.pressure then
				Result := true
			end
		end


	update
			-- update the observer's view of `s'
		do
			last_pressure := current_pressure
			current_pressure := weather_data.pressure
			display
		end

	display
		do
			if current_pressure > last_pressure then
				print("Improving weather on the way!%N")
			elseif current_pressure = last_pressure then
					print("More of the same%N")
			elseif current_pressure < last_pressure then
					print("Watch out for cooler, rainy weather%N")
			end
		end




end
