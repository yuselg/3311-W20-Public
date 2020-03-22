note
	description: "Summary description for {CURRENT_CONDITIONS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CURRENT_CONDITIONS

inherit
	OBSERVER
create
	make

feature{NONE} -- initialize
	make(a_weather_data: WEATHER_DATA_SUBJECT)
		do
			weather_data := a_weather_data
			weather_data.attach (Current)
		ensure
			weather_data = a_weather_data
			weather_data.observers.has (Current)
		end

feature
	temperature: REAL
	humidity: REAL
	weather_data: WEATHER_DATA_SUBJECT -- subject

	up_to_date_with_subject: BOOLEAN
			-- is this observer up to date with its subject
		do
			if temperature = weather_data.temperature and humidity = weather_data.humidity then
				Result := true
			end
		ensure then
			Result implies temperature = weather_data.temperature
			Result implies humidity = weather_data.humidity
		end


	update
			-- update the observer's view of `s'
		do
			temperature := weather_data.temperature
			humidity := weather_data.humidity
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
