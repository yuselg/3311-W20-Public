note
	description: "[
		Broker provides a Singleton Event Type 
		for weather station updates.
		Other event types may be added as neecssary.
		]"

expanded class
	BROKER

feature
	weather_event: EVENT_TYPE[
			TUPLE[temperature:REAL; pressure:REAL; humidity:REAL]
		]
			-- event type for weather station
		once
			create Result
		end

end

