note
	description: "Summary description for {WEATHER_DATA_SUBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEATHER_DATA_SUBJECT
inherit
	WEATHER_DATA
create
	make

feature{NONE}
	broker: BROKER -- expanded singleton

feature --effect measurements_changed

	measurements_changed
		do
			-- [temperature,pressure,humidity]
			broker.weather_event.publish (temperature,pressure,humidity)
		end
end

