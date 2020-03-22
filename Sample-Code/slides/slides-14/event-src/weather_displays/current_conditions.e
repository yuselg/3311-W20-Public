note
	description: "Summary description for {CURRENT_CONDITIONS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class CURRENT_CONDITIONS create
	make
feature{NONE} -- constructor

	broker: BROKER -- expanded singleton

	make
			-- subscribe to weather event type in broker
		do
			broker.weather_event.subscribe (agent update)
		end
feature
	temperature: REAL
	humidity: REAL


	update(t,p,h:REAL)
			-- update the observer's view of `s'
		do
			temperature := t
			humidity := h
			display
		end

	display
			-- display current conditions
		do
			io.put_string("Current Conditions: ")
			io.put_real (temperature)
			io.put_string (" degrees C and ")
			io.put_real (humidity)
			io.put_string (" percent humidity%N")
		end


end
