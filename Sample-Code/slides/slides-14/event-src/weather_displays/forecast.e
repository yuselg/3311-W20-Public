note
	description: "Summary description for {FORECAST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FORECAST

create
	make

feature {NONE} --creation
	make
		do
			broker.weather_event.subscribe (agent update)
		end

feature

	current_pressure: REAL
	last_pressure: REAL

	broker: BROKER



	update(t,p,h:REAL)
			-- update the observer's view of `s'
		do
			last_pressure := current_pressure
			current_pressure := p
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
