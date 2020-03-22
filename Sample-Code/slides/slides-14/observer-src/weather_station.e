note
	description: "Summary description for {WEATHER_STATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEATHER_STATION
create
	make
feature
	cc: CURRENT_CONDITIONS
	fd: FORECAST
	sd: STATISTICS
	wd: WEATHER_DATA_SUBJECT

	make
		do
			create {WEATHER_DATA_SUBJECT}wd.make
			create cc.make (wd)
			create fd.make (wd)
			create sd.make(wd)

			io.new_line
			wd.set_measurements (15, 60, 30.4)
			wd.measurements_changed
			print("-----------%N")

			wd.set_measurements (19, 56, 20)
			wd.measurements_changed
			print("-----------%N")

			wd.set_measurements (11, 90, 20)
			wd.measurements_changed
			print("-----------%N")

--			io.read_character
		end

end
