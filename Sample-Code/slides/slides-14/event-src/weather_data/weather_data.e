note
	description: "Summary description for {WEATHER_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEATHER_DATA

inherit

	DBC_SUPPORT

feature -- weather data available to observers

	temperature: REAL
	humidity: REAL
	pressure: REAL

	correct_limits(t,p,h: REAL): BOOLEAN
		do
			if -36 <= t and t <= 60
				and 50 <= p and p <= 110 -- kPa
				and 0.8 <= h and h <= 100 -- %R
			then
				Result := true
			end
		ensure
			comment("temperature in centigrade")
			Result implies -36 <=t and t <= 60
			comment ("pressure in kPA and humidity in %RH")
			Result implies 50 <= p and p <= 110
			Result implies 0.8 <= h and h <= 100
		end

feature  -- weather station interface
	set_measurements(t,p,h: REAL)
			-- called from weather station
		require
			correct_limits(t,p,h)
		do
			temperature := t
			humidity := h
			pressure := p
		ensure
			temperature = t
			pressure = p
			humidity = h
		end

	measurements_changed
			-- called from weather station after set
		deferred
		end

feature {NONE} -- make

	make
		do
			temperature := 0
			pressure := 100
			humidity := 50
		ensure then
			temperature = 0 and pressure = 100 and humidity = 50
		end


invariant
	correct_limits(temperature, pressure, humidity)

end
